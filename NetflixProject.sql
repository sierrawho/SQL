-- REMOVE EPISODE AND BLANK CELL 

--UPDATE NetflixViewingHistory 
--SET Title = LEFT(Title, CHARINDEX(':', Title) - 1)
--WHERE CHARINDEX(':', Title) > 0

-- adding physical 100 back
--UPDATE NetflixViewingHistory
--SET Title = REPLACE(Title, 'Physical', 'Physical: 100')

--Fixed Titles 
--UPDATE NetflixViewingHistory
--SET Title = REPLACE(Title, 'Degrassi', 'Degrassi: Next Class');

--Remove blank
--DELETE NetflixViewingHistory 
--WHERE Title = ''

--joining tables
SELECT NetflixViewingHistory.Title, NetFlix.release_year, NetFlix.genres, NetflixViewingHistory.[Date], NetFlix.[type], NetFlix.country
FROM NetflixViewingHistory
LEFT JOIN NetFlix ON NetflixViewingHistory.Title= NetFlix.title
ORDER BY NetflixViewingHistory.[Date];

-- Make a table of all Null (No longer on netflix OR are too new for this netflix dataset)
SELECT DISTINCT(NetflixViewingHistory.Title), NetFlix.release_year, NetFlix.genres, NetFlix.[type]
FROM NetflixViewingHistory
LEFT JOIN NetFlix ON NetflixViewingHistory.Title= NetFlix.title
WHERE NetFlix.release_year IS NULL OR NetFlix.genres IS NULL or NetFlix.[type] IS NULL;

-- count how many movies and shows i've watched
SELECT NetFlix.[type], Count(NetFlix.[type]) AS 'Num of shows vs movies'
FROM NetflixViewingHistory
LEFT JOIN NetFlix ON NetflixViewingHistory.Title= NetFlix.title
WHERE NetFlix.[type] = 'TV Show' OR NetFlix.[type] = 'Movie'
 GROUP by NetFlix.[type];

 --top shows ive watched remove distinct 
SELECT TOP 10 NetflixViewingHistory.Title, Count(NetFlix.Title) AS 'Watch_Time'
FROM NetflixViewingHistory
LEFT JOIN NetFlix ON NetflixViewingHistory.Title= NetFlix.title
WHERE NetFlix.[type] = 'TV Show' 
GROUP by NetflixViewingHistory.Title
ORDER BY [Watch_Time] DESC;

-- how many distinct shows and movies have I watch that were not null
SELECT  Netflix.[type], COUNT(DISTINCT(NetflixViewingHistory.Title)) AS 'Num of shows/movies'
FROM NetflixViewingHistory
LEFT JOIN NetFlix ON NetflixViewingHistory.Title= NetFlix.title
WHERE [type] = 'Movie' OR [type] = 'TV Show'
GROUP BY NetFlix.[type]

-- Top movie genres
SELECT  TOP 10 NetFlix.genres, COUNT(NetFlix.genres) AS Watch_time
FROM NetflixViewingHistory
LEFT JOIN NetFlix ON NetflixViewingHistory.Title= NetFlix.title
WHERE NetFlix.[type] = 'Movie'
GROUP BY NetFlix.genres
ORDER by Watch_time DESC;

--Where are my tv shows from
SELECT TOP 10 (NetFlix.country), Count(Distinct NetflixViewingHistory.Title) AS 'Total' 
FROM NetflixViewingHistory
LEFT JOIN NetFlix ON NetflixViewingHistory.Title = NetFlix.title
WHERE NetFlix.country IS NOT NULL AND [type] = 'TV Show'
GROUP BY NetFlix.country 
ORDER BY [Total] DESC;

--Where are my tv shows from
SELECT (NetFlix.rating), Count(Distinct NetflixViewingHistory.Title) AS 'Total' 
FROM NetflixViewingHistory
LEFT JOIN NetFlix ON NetflixViewingHistory.Title = NetFlix.title
WHERE NetFlix.rating IS NOT NULL
GROUP BY NetFlix.rating 
ORDER BY [Total] DESC;

--The year of the shows that I watch
SELECT (NetFlix.release_year), Count(DISTINCT NetflixViewingHistory.Title) AS 'Total' 
FROM NetflixViewingHistory
LEFT JOIN NetFlix ON NetflixViewingHistory.Title = NetFlix.title
WHERE NetFlix.release_year IS NOT NULL AND [type] = 'TV Show'
GROUP BY NetFlix.release_year
ORDER BY [Total] DESC;