CREATE OR REPLACE FUNCTION
deleteSomeOrdersFunction(maxOrderDeletions INTEGER)
RETURNS INTEGER AS $$

    DECLARE
        totalDeleted        INTEGER := 0;  -- Total number of orders deleted
        futureOrderCount    INTEGER;       -- Number of future orders for a supplier
        theSupplierID       INTEGER;       -- Supplier currently being considered

    DECLARE supplierCursor CURSOR FOR
        SELECT os.supplierID
        FROM OrderSupply os
        WHERE os.orderDate <= DATE '2024-01-05'
          AND os.status = 'cnld'
        GROUP BY os.supplierID
        ORDER BY COUNT(*) DESC, os.supplierID;

    BEGIN
        -- Input validation
        IF maxOrderDeletions <= 0 THEN
            RETURN -1;  -- Invalid input
        END IF;

        OPEN supplierCursor;

        LOOP
            FETCH supplierCursor INTO theSupplierID;

            -- Exit if no more suppliers
            EXIT WHEN NOT FOUND;

            -- Count the number of future orders for this supplier
            SELECT COUNT(*) INTO futureOrderCount
            FROM OrderSupply
            WHERE supplierID = theSupplierID
              AND orderDate > DATE '2024-01-05';

            -- If deleting these would exceed the allowed maximum, stop
            IF totalDeleted + futureOrderCount > maxOrderDeletions THEN
                EXIT;
            END IF;

            -- Delete all future orders for this supplier
            DELETE FROM OrderSupply
            WHERE supplierID = theSupplierID
              AND orderDate > DATE '2024-01-05';

            totalDeleted := totalDeleted + futureOrderCount;
        END LOOP;

        CLOSE supplierCursor;

        RETURN totalDeleted;

    EXCEPTION
        WHEN OTHERS THEN
            RETURN -1;
END;
$$ LANGUAGE plpgsql;
