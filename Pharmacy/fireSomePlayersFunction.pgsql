CREATE OR REPLACE FUNCTION
fireSomePlayersFunction(maxFired INTEGER)
RETURNS INTEGER AS $$


    DECLARE
    	numFired		INTEGER;	  /* Number actually fired, the value returned */
    	thePlayerID	INTEGER;  /* The player to be fired */

    DECLARE firingCursor CURSOR FOR
    	    SELECT p.personID
            FROM Persons p, Players play, GamePlayers gp
            WHERE p.personID = play.playerID 
              AND play.playerID = gp.playerID
              AND play.rating = 'L'
              AND play.teamID IS NOT NULL
            GROUP BY p.personID
            HAVING SUM(gp.minutesPlayed) > 60
            ORDER BY p.salary DESC;

    BEGIN

	-- Input Validation
	IF maxFired <= 0 THEN
	    RETURN -1;		/* Illegal value of maxFired */
	    END IF;

        numFired := 0;

        OPEN firingCursor;

        LOOP
 
            FETCH firingCursor INTO thePlayerID;

            -- Exit if there are no more records for firingCursor,
            -- or when we already have performed maxFired firings.
            EXIT WHEN NOT FOUND OR numFired >= maxFired;

            UPDATE Players
            SET teamID = NULL
            WHERE playerID = thePlayerID;

            numFired := numFired + 1;

        END LOOP;
        CLOSE firingCursor;

	RETURN numFired;

    END

$$ LANGUAGE plpgsql;
