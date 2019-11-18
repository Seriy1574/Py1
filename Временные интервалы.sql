-- пример подсчета одновременно звонящих пользователей

mysql> CREATE DATABASE alfa;
mysql> USE alfa;

DROP TABLE alfa.calls;
mysql> CREATE TABLE calls
(ID_USER INT UNSIGNED NOT NULL,DT_CALL_START DATETIME NOT NULL,DT_CALL_END DATETIME);

mysql> INSERT INTO calls (ID_USER,DT_CALL_START,DT_CALL_END)
VALUE

    -> (1,  '2019-01-15  9:00:00',   '2019-01-15  9:02:23'),
    -> (1,  '2019-01-15  9:09:33',   '2019-01-15  9:09:47'),
    -> (1,  '2019-01-15  9:15:11',   '2019-01-15  9:20:05'),
    -> (1,  '2019-01-15  9:25:07',   '2019-01-15  9:28:56'),
    -> (2,  '2019-01-15 9:01:00',   '2019-01-15  9:01:59'),
    -> (2,  '2019-01-15  9:05:05',   '2019-01-15  9:05:23'),
    -> (2,  '2019-01-15   9:12:52',   '2019-01-15  9:16:52'),
    -> (2,  '2019-01-15   9:18:13',   '2019-01-15  9:22:49'),
    -> (2,  '2019-01-15   9:29:01',   '2019-01-15  9:29:39'),
    -> (3,  '2019-01-15   9:05:36',   '2019-01-15  9:07:00'),
    -> (3,  '2019-01-15  9:12:52',   '2019-01-15  9:15:30'),
    -> (3,  '2019-01-15  9:17:16',   '2019-01-15  9:20:16'),
    -> (3,  '2019-01-15  9:25:47',   '2019-01-15  9:30:02'),
    -> (3,  '2019-01-15  9:35:13',   '2019-01-15  9:36:44'),
    -> (4,  '2019-01-15 9:04:17',   '2019-01-15  9:05:07'),
    -> (4,  '2019-01-15  9:05:56',   '2019-01-15  9:06:31'),
    -> (4,  '2019-01-15  9:14:09',   '2019-01-15  9:14:53'),
    -> (4,  '2019-01-15 9:18:00',   '2019-01-15  9:19:28');





SELECT max(t.max_users)+1 FROM (SELECT c1.DT_CALL_START, COUNT(DISTINCT c2.ID_USER) AS max_users
                       FROM alfa.calls c1
                            LEFT JOIN alfa.calls c2
                              ON c1.ID_USER != c2.ID_USER
                             AND ((c1.DT_CALL_START > c2.DT_CALL_START AND c1.DT_CALL_END > c2.DT_CALL_END AND c1.DT_CALL_START < c2.DT_CALL_END)
                              OR  (c1.DT_CALL_START < c2.DT_CALL_START AND c1.DT_CALL_END < c2.DT_CALL_END AND c1.DT_CALL_END > c2.DT_CALL_START)
                              OR  (c1.DT_CALL_START < c2.DT_CALL_START AND c1.DT_CALL_END > c2.DT_CALL_END)
                              OR  (c1.DT_CALL_START > c2.DT_CALL_START AND c1.DT_CALL_END < c2.DT_CALL_END)
                              ) 
GROUP BY c1.DT_CALL_START)t;


+------------------+
| max(t.max_users) |
+------------------+
|                4 |
+------------------+

