SELECT
            `tr`.`id`       AS 'Track_ID',
            `tr`.`name`     AS 'Track_Name',
            `tr`.`artist`   AS 'Track_Artist',
            `vt`.`updated_at`
                            AS 'Track_Latest_Vote_Timestamp',
            IFNULL(`vu`.`votes`, 0)
                            AS 'Track_Up_Votes',
            IFNULL(`vd`.`votes`, 0)
                            AS 'Track_Down_Votes',
            (
                IFNULL(`vu`.`votes`, 0) -
                IFNULL(`vd`.`votes`, 0)
            )               AS 'Track_Nominal_Position'
FROM        `tracks`        AS `tr`
LEFT JOIN   `votes`         AS `vt` ON  `vt`.`track_id`     = `tr`.`id`
                                    AND `vt`.`updated_at`   = 
                                                            (
                                                                SELECT  MAX(`updated_at`)
                                                                FROM    `votes` 
                                                                WHERE   `track_id` = `tr`.`id`
                                                            )
LEFT JOIN   (
                SELECT 
                            `vv`.`track_id`     AS 'uID',
                            COUNT(`vv`.`vote`)  AS 'votes'
                FROM        `votes`             AS `vv`
                WHERE       `vv`.`vote` = "t"
                GROUP BY    `vv`.`track_id`
            )               AS `vu` ON  `vu`.`uID` = `tr`.`id`
LEFT JOIN   (
                SELECT 
                            `vv`.`track_id`     AS 'uID',
                            COUNT(`vv`.`vote`)  AS 'votes'
                FROM        `votes`             AS `vv`
                WHERE       `vv`.`vote` = "f"
                GROUP BY    `vv`.`track_id`
            )               AS `vd` ON  `vd`.`uID` = `tr`.`id`
GROUP BY
            `tr`.`track_id`
ORDER BY
            `Track_Nominal_Position` DESC,
            `vt`.`updated_at` ASC
LIMIT       0, 100;