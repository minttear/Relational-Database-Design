INSERT INTO USER_INFOR(USER_ID,FIRST_NAME,LAST_NAME,YEAR_OF_BIRTH,MONTH_OF_BIRTH,DATE_OF_BIRTH,GENDER)
SELECT DISTINCT USER_ID,FIRST_NAME,LAST_NAME,YEAR_OF_BIRTH,MONTH_OF_BIRTH,DAY_OF_BIRTH,GENDER
FROM KEYKHOLT.PUBLIC_USER_INFORMATION;

INSERT INTO LOCATION(CITY,STATE,COUNTRY)
SELECT DISTINCT HOMETOWN_CITY, HOMETOWN_STATE, HOMETOWN_COUNTRY FROM KEYKHOLT.PUBLIC_USER_INFORMATION
UNION
SELECT DISTINCT CURRENT_CITY, CURRENT_STATE, CURRENT_COUNTRY FROM KEYKHOLT.PUBLIC_USER_INFORMATION
UNION
SELECT DISTINCT EVENT_CITY, EVENT_STATE, EVENT_COUNTRY FROM KEYKHOLT.PUBLIC_EVENT_INFORMATION;

INSERT INTO CURRENT_LOCATION(USER_ID,LOCATION_ID)
SELECT DISTINCT P.USER_ID, L.LOCATION_ID
FROM KEYKHOLT.PUBLIC_USER_INFORMATION P,LOCATION L
WHERE (P.CURRENT_CITY=L.CITY)AND(P.CURRENT_STATE=L.STATE)AND(P.CURRENT_COUNTRY=L.COUNTRY);


INSERT INTO HOMETOWN_LOCATION(USER_ID,LOCATION_ID)
SELECT DISTINCT P.USER_ID, L.LOCATION_ID
FROM KEYKHOLT.PUBLIC_USER_INFORMATION P,LOCATION L,USER_INFOR U
WHERE (P.HOMETOWN_CITY=L.CITY)AND(P.HOMETOWN_STATE=L.STATE)AND(P.HOMETOWN_COUNTRY=L.COUNTRY);

INSERT INTO COLLEGE_PROGRAM(INSTITUTION_NAME,DEGREE,CONCENTRATION)
SELECT DISTINCT INSTITUTION_NAME,PROGRAM_DEGREE,PROGRAM_CONCENTRATION
FROM KEYKHOLT.PUBLIC_USER_INFORMATION;

INSERT INTO ATTENDED (USER_ID,PROGRAM_ID,GRADUATION_YEAR)
SELECT DISTINCT P.USER_ID,C.PROGRAM_ID,P.PROGRAM_YEAR
FROM KEYKHOLT.PUBLIC_USER_INFORMATION P,USER_INFOR U,COLLEGE_PROGRAM C
WHERE (P.INSTITUTION_NAME=C.INSTITUTION_NAME)
AND(P.PROGRAM_DEGREE=C.DEGREE)AND(P.PROGRAM_CONCENTRATION=C.CONCENTRATION);

INSERT INTO FRIEND_OF(USER_ID1,USER_ID2)
SELECT DISTINCT USER1_ID,USER2_ID
FROM KEYKHOLT.PUBLIC_ARE_FRIENDS;

SET AUTOCOMMIT OFF

INSERT INTO ALBUM_BELONG(ALBUM_ID,OWNER_ID,ALBUM_NAME,ALBUM_LINK,COVER_PHOTO_ID,ALBUM_CREATED_TIME,ALBUM_MODIFIED_TIME,ALBUM_VISIBILITY)
SELECT DISTINCT P.ALBUM_ID,P.OWNER_ID,P.ALBUM_NAME,P.ALBUM_LINK,P.COVER_PHOTO_ID,P.ALBUM_CREATED_TIME,P.ALBUM_MODIFIED_TIME,P.ALBUM_VISIBILITY
FROM KEYKHOLT.PUBLIC_PHOTO_INFORMATION P;


INSERT INTO PHOTO
SELECT DISTINCT PHOTO_ID, PHOTO_CAPTION, PHOTO_CREATED_TIME,
    PHOTO_MODIFIED_TIME, PHOTO_LINK, ALBUM_ID
    FROM KEYKHOLT.PUBLIC_PHOTO_INFORMATION;

INSERT INTO TAG
SELECT DISTINCT PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME,
    TAG_X_COORDINATE, TAG_Y_COORDINATE
    FROM KEYKHOLT.PUBLIC_TAG_INFORMATION;

INSERT INTO EVENT
SELECT DISTINCT EVENT_ID, EVENT_CREATOR_ID, EVENT_NAME, EVENT_TAGLINE,
    EVENT_DESCRIPTION, EVENT_TYPE, EVENT_HOST, EVENT_SUBTYPE,
    EVENT_LOCATION, EVENT_START_TIME, EVENT_END_TIME
    FROM KEYKHOLT.PUBLIC_EVENT_INFORMATION;

INSERT INTO EVENT_AT
SELECT DISTINCT P.EVENT_ID, L.LOCATION_ID
     FROM KEYKHOLT.PUBLIC_EVENT_INFORMATION P, 
	LOCATION L
    WHERE L.CITY = P.EVENT_CITY AND L.STATE = P.EVENT_STATE
        AND L.COUNTRY = P.EVENT_COUNTRY;

