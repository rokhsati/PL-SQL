CREATE OR REPLACE PACKAGE input_validation_pkg AS
    FUNCTION validate_input(
        p_input_value IN VARCHAR2,
        p_type        IN VARCHAR2
    ) RETURN BOOLEAN;
END input_validation_pkg;

CREATE OR REPLACE PACKAGE BODY input_validation_pkg AS

    FUNCTION is_sql_injection(p_value IN VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        IF p_value IS NULL THEN
            RETURN TRUE;
        END IF;

        IF UPPER(p_value) LIKE '%;%' OR
           UPPER(p_value) LIKE '%--%' OR
           UPPER(p_value) LIKE '%/%' OR
           UPPER(p_value) LIKE '%OR%' OR
           UPPER(p_value) LIKE '%AND%' OR
           UPPER(p_value) LIKE '%SELECT%' OR
           UPPER(p_value) LIKE '%INSERT%' OR
           UPPER(p_value) LIKE '%DELETE%' OR
           UPPER(p_value) LIKE '%UPDATE%' OR
           UPPER(p_value) LIKE '%DROP%' THEN
            RETURN TRUE;
        END IF;

        RETURN FALSE;
    END is_sql_injection;

    FUNCTION validate_input(
        p_input_value IN VARCHAR2,
        p_type        IN VARCHAR2
    ) RETURN BOOLEAN IS
        v_is_valid BOOLEAN := FALSE;
    BEGIN
        IF is_sql_injection(p_input_value) THEN
            RAISE_APPLICATION_ERROR(-20002, 'Potential SQL injection detected in input.');
        END IF;

        IF p_type = 'number' THEN
            BEGIN
                DECLARE
                    v_dummy NUMBER;
                BEGIN
                    v_dummy := TO_NUMBER(p_input_value);
                    v_is_valid := TRUE;
                EXCEPTION
                    WHEN OTHERS THEN
                        v_is_valid := FALSE;
                END;
            END;

        ELSIF p_type = 'text' THEN
            IF p_input_value IS NOT NULL THEN
                v_is_valid := TRUE;
            END IF;

        ELSIF p_type = 'boolean' THEN
            IF UPPER(p_input_value) IN ('TRUE', 'FALSE') THEN
                v_is_valid := TRUE;
            END IF;

        ELSIF p_type = 'date' THEN
            BEGIN
                DECLARE
                    v_dummy DATE;
                BEGIN
                    v_dummy := TO_DATE(p_input_value, 'YYYY-MM-DD');
                    v_is_valid := TRUE;
                EXCEPTION
                    WHEN OTHERS THEN
                        v_is_valid := FALSE;
                END;
            END;

        ELSIF p_type = 'email' THEN
            IF REGEXP_LIKE(p_input_value, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$') THEN
                v_is_valid := TRUE;
            END IF;

        ELSIF p_type = 'phone' THEN
            IF REGEXP_LIKE(p_input_value, '^\+?[0-9]{1,3}?[-. ]?[0-9]{1,4}[-. ]?[0-9]{1,4}[-. ]?[0-9]{1,9}$') THEN
                v_is_valid := TRUE;
            END IF;

        ELSIF p_type = 'url' THEN
            IF REGEXP_LIKE(p_input_value, '^(http|https)://[a-zA-Z0-9.-]+(\.[a-zA-Z]{2,})?(/.*)?$') THEN
                v_is_valid := TRUE;
            END IF;

        ELSIF p_type = 'alphanumeric' THEN
            IF REGEXP_LIKE(p_input_value, '^[A-Za-z0-9]+$') THEN
                v_is_valid := TRUE;
            END IF;

        ELSIF p_type = 'length' THEN
            IF LENGTH(p_input_value) BETWEEN 8 AND 20 THEN
                v_is_valid := TRUE;
            END IF;

        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'Invalid type specified. Allowed types are: number, text, boolean, date, email, phone, url, alphanumeric, length.');
        END IF;

        RETURN v_is_valid;
    END validate_input;

END input_validation_pkg;
