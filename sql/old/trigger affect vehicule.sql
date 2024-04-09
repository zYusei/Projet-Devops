DROP TRIGGER IF EXISTS AFFECTATION_VEHICULE ;

DELIMITER $

CREATE TRIGGER AFFECTATION_VEHICULE BEFORE INSERT ON 
PLANNING FOR EACH ROW BEGIN 
	declare idvehicule, x int;
	select count(*) into x from planning where id_e = new.id_e;
	if x > 0 then
	select
	    matricule into idvehicule
	from planning p
	where
	    p.id_e = new.id_e
	    and datehf = (
	        select min(datehf)
	        from planning
	        where id_e = new.id_e
	    );
	ELSEIF (
	    SELECT nom_f
	    FROM formule
	    WHERE id_f = (
	            SELECT id_f
	            FROM eleve
	            WHERE
	                id_e = new.id_e
	        )
	) like '%Permis B%' THEN
	select
	    matricule into idvehicule
	from vehicule v
	where v.type_boite = (
	        SELECT type_boite
	        FROM formule
	        WHERE id_f = (
	                SELECT id_f
	                FROM eleve
	                WHERE
	                    id_e = new.id_e
	            )
	    )
	    and type_v = '4 roues'
	order by RAND()
	limit 1;
	ELSEIF (
	    SELECT nom_f
	    FROM formule
	    WHERE id_f = (
	            SELECT id_f
	            FROM eleve
	            WHERE
	                id_e = new.id_e
	        )
	) like '%Permis A%' THEN
	select
	    matricule into idvehicule
	from vehicule v
	where v.type_boite = (
	        SELECT type_boite
	        FROM formule
	        WHERE id_f = (
	                SELECT id_f
	                FROM eleve
	                WHERE
	                    id_e = new.id_e
	            )
	    )
	    and type_v = '2 roues'
	order by RAND()
	limit 1;
	END IF;
	IF idvehicule in (
	    select matricule
	    from planning p
	    where (
	            new.datehd >= datehd
	            and new.datehd <= datehf
	            or new.datehf >= datehd
	            and new.datehf <= datehf
	        )
	) then (
	    select
	        matricule into idvehicule
	    from vehicule
	    where matricule not in (
	            select matricule
	            from planning p
	            where (
	                    new.datehd >= datehd
	                    and new.datehd <= datehf
	                    or new.datehf >= datehd
	                    and new.datehf <= datehf
	                )
	        )
	    order by RAND()
	    limit 1
	);
	END IF;
	set new.matricule = idvehicule;
	END 
$ 

DELIMITER ;

DROP TRIGGER IF EXISTS AFFECTATION_MONITEUR ;

DELIMITER $

CREATE TRIGGER AFFECTATION_MONITEUR BEFORE INSERT ON 
PLANNING FOR EACH ROW BEGIN 
	DECLARE id_moniteur INT;
	SELECT id_m INTO id_moniteur
	FROM planning
	WHERE id_e = NEW.id_e
	ORDER BY datehd ASC
	LIMIT 1;
	IF id_moniteur IS NULL THEN
	SELECT id_u INTO id_moniteur
	FROM USER
	WHERE
	    role_u = 'moniteur'
	    AND id_u NOT IN (
	        SELECT id_m
	        FROM planning
	    )
	LIMIT 1;
	END IF;
	IF id_moniteur IS NULL THEN
	SELECT id_m INTO id_moniteur
	FROM (
	        SELECT
	            id_m,
	            COUNT(*) AS nb_heures
	        FROM planning
	        GROUP BY id_m
	        ORDER BY
	            nb_heures ASC
	    ) AS t
	LIMIT 1;
	END IF;
	SET NEW.id_m = id_moniteur;
	END 
$ 

DELIMITER ;

DROP TRIGGER IF EXISTS AFFECTATION_VEHICULE ;

DELIMITER $

CREATE TRIGGER AFFECTATION_VEHICULE BEFORE INSERT ON 
PLANNING FOR EACH ROW BEGIN 
	DECLARE idvehicule VARCHAR(50);
	DECLARE x INT;
	SELECT COUNT(*) INTO x
	FROM planning
	WHERE
	    id_e = NEW.id_e
	    AND matricule NOT IN (
	        SELECT matricule
	        FROM planning
	        WHERE (
	                NEW.datehd >= datehd
	                AND NEW.datehd <= datehf
	            )
	            OR (
	                NEW.datehf >= datehd
	                AND NEW.datehf <= datehf
	            )
	    );
	IF x > 0 THEN
	SELECT
	    matricule INTO idvehicule
	FROM planning p
	WHERE
	    p.id_e = NEW.id_e
	    AND datehf = (
	        SELECT MIN(datehf)
	        FROM planning
	        WHERE id_e = NEW.id_e
	    );
	ELSEIF (
	    SELECT nom_f
	    FROM formule
	    WHERE id_f = (
	            SELECT
	                id_formation
	            FROM eleve
	            WHERE
	                id_u = new.id_e
	        )
	) like '%Permis B%' THEN
	select
	    matricule into idvehicule
	from vehicule v
	where v.type_boite = (
	        SELECT type_boite
	        FROM formule
	        WHERE id_f = (
	                SELECT
	                    id_formation
	                FROM eleve
	                WHERE
	                    id_u = new.id_e
	            )
	    )
	    and type_v = '4 roues'
	    and matricule not in (
	        select matricule
	        from planning p
	        where (
	                new.datehd >= datehd
	                and new.datehd <= datehf
	                or new.datehf >= datehd
	                and new.datehf <= datehf
	            )
	    )
	order by RAND()
	limit 1;
	ELSEIF (
	    SELECT nom_f
	    FROM formule
	    WHERE id_f = (
	            SELECT
	                id_formation
	            FROM eleve
	            WHERE
	                id_u = new.id_e
	        )
	) like '%Permis A%'
	or '%Passerelle A%' THEN
	select
	    matricule into idvehicule
	from vehicule v
	where v.type_boite = (
	        SELECT type_boite
	        FROM formule
	        WHERE id_f = (
	                SELECT
	                    id_formation
	                FROM eleve
	                WHERE
	                    id_u = new.id_e
	            )
	    )
	    and type_v = '2 roues'
	    and matricule not in (
	        select matricule
	        from planning p
	        where (
	                new.datehd >= datehd
	                and new.datehd <= datehf
	                or new.datehf >= datehd
	                and new.datehf <= datehf
	            )
	    )
	order by RAND()
	limit 1;
	END IF;
	SET NEW.matricule = idvehicule;
	END 
$ 

DELIMITER ;