CREATE OR REPLACE FUNCTION get_coordinates()
RETURNS jsonb AS $$
DECLARE
    result_json jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(bird_location))
    INTO result_json
    FROM bird_location;
    
    RETURN result_json;
END;
$$ LANGUAGE plpgsql;


--SELECT get_coordinates();
