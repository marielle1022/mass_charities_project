USE mass_nonprofits;

-- Desktop/databases/assignments/project/final_project

-- Operation 1: Add a language to the database
-- Language to add: Farsi
SELECT * FROM languages;


-- Operation 2: Update the target population for an organization
-- New target population: All immigrants and refugees statewide
CALL find_org_name('Office of Health Equity');