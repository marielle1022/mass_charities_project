USE mass_nonprofits;

SELECT * FROM organizations
	JOIN
    regions
    ON regions.regionNo = organizations.region
    JOIN
    (SELECT GROUP_CONCAT(name) FROM languages_spoken
		JOIN
		languages
		ON languages_spoken.language = languages.languageNo
        WHERE organization = 1) AS ls
	JOIN
    (SELECT GROUP_CONCAT(serviceType) FROM services_offered
		JOIN
		services
		ON services_offered.service = services.serviceNo
        WHERE organization = 1) AS so;
    
SELECT * from languages_spoken;
SELECT GROUP_CONCAT(language) FROM languages_spoken
	WHERE organization = 1;
SELECT GROUP_CONCAT(name) from languages_spoken
	JOIN
    languages
	ON languages_spoken.language = languages.languageNo
    WHERE organization = 2;
SELECT * from languages_spoken;
SELECT * FROM languages;
SELECT * FROM organizations;
SELECT * FROM languages_spoken
	JOIN
	languages
    ON languages_spoken.language = languages.languageNo;