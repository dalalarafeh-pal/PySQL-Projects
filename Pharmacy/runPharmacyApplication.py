import psycopg2, sys, datetime

def countNumberOfCustomers (myConn, thePharmacyID):
    try:
        myCursor = myConn.cursor()

        myCursor.execute("SELECT COUNT(*) FROM Pharmacy WHERE pharmacyID = %s", (thePharmacyID,))
        if myCursor.fetchone()[0]== 0:
            myCursor.close()
            return -1

        myCursor.execute("SELECT COUNT(DISTINCT customerID) FROM Purchase WHERE pharmacyID = %s", (thePharmacyID,))
        count = myCursor.fetchone()[0]
        myCursor.close()
        return count

    except:
        return -1

def updateOrderStatus (myConn, currentYear):
    if not (2000 <= currentYear <= 2030):
        return -1
    try:
        myCursor = myConn.cursor()
        stmt = """UPDATE OrderSupply SET status = status || ' AS OF ' || %s WHERE status IN ('dlvd', 'pndg')"""
        myCursor.execute(stmt, (str(currentYear),))
        k = myCursor.rowcount
        myCursor.close()
        return k
    except:
        return -1

def deleteSomeOrders (myConn, maxOrderDeletions):
    try:
        myCursor = myConn.cursor()
        sql = "SELECT deleteSomeOrdersFunction(%s)"
        myCursor.execute(sql, (maxOrderDeletions, ))
    except:
        print("Call of deleteSomeOrdersFunction with argument", maxOrderDeletions, "had error", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)

    row = myCursor.fetchone()
    myCursor.close()
    return(row[0])

def main():
    port = "5432"
    userID = "cse182"
    pwd = "database4me"
    try:
        myConn = psycopg2.connect(port=port, user=userID, password=pwd)
    except:
        print("Connection to database failed", file=sys.stderr)
        sys.exit(-1)

    myConn.autocommit = True

    test_cases = {
        "countNumberOfCustomers": [11, 17, 44, 66],
        "updateOrderStatus": [1999, 2025, 2031],
        "deleteSomeOrders": [2, 4, 3, 1]
    }
 
    print("\nTesting countNumberOfCustomers")
    for pharmacy_id in test_cases["countNumberOfCustomers"]:
        result = countNumberOfCustomers(myConn, pharmacy_id)
        if result >= 0:
            print(f"Number of customers for pharmacy {pharmacy_id} is {result}\n")
        else:
            print(f"Error: Pharmacy ID {pharmacy_id} is invalid or caused an error.\n")

    print("Testing updateOrderStatus\n")
    for year in test_cases["updateOrderStatus"]:
        result = updateOrderStatus(myConn, year)
        if result < 0:
            print(f"Error: Invalid year {year}. No updates made.\n")
        else:
            print(f"Number of orders whose status values were updated by updateOrderStatus is {result}\n")

    print("Testing deleteSomeOrders\n")
    for limit in test_cases["deleteSomeOrders"]:
        result = deleteSomeOrders(myConn, limit)
        if result < 0:
            print(f"Error: maxOrderDeletions = {limit}. No deletions performed.\n")
        else:
            print(f"Number of orders which were deleted for maxOrderDeletions value {limit} is {result}\n")

    myConn.close()
    sys.exit(0)

if __name__=='__main__':
    main()
