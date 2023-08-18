CREATE OR REPLACE FUNCTION get_all_sites_json()
RETURNS JSON AS $$
DECLARE
    result_json JSON;
BEGIN
    SELECT json_agg(row_to_json(sites)) INTO result_json FROM sites;
    RETURN result_json;
END;
$$ LANGUAGE plpgsql;


--SELECT get_all_sites_json();
