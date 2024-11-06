# PL/SQL Input Validation Package

## Overview

This repository contains a PL/SQL package named `input_validation_pkg` designed to validate user input based on specified types. The package includes checks for various input formats and incorporates SQL injection protection to enhance security.

## Features

- **Type Validation**: The package supports validation for the following input types:
  - **Number**: Validates if the input can be converted to a numeric value.
  - **Text**: Accepts any non-null string as valid text.
  - **Boolean**: Validates if the input is either 'TRUE' or 'FALSE' (case-insensitive).
  - **Date**: Checks if the input can be converted to a valid date format.
  - **Email**: Validates if the input matches a basic email format using a regular expression.
  - **Phone**: Validates if the input matches a specific phone number format.
  - **URL**: Checks if the input is a well-formed URL.
  - **Alphanumeric**: Validates if the input contains only alphanumeric characters.
  - **Length**: Validates the length of the input based on specified criteria.

- **SQL Injection Protection**: The package includes checks for common SQL injection patterns, raising an error if potentially harmful input is detected.

## Usage

You can call the `validate_input` function in your PL/SQL blocks or procedures to ensure that user inputs are validated and safe from SQL injection attacks.

### Example

```sql
DECLARE
    v_result BOOLEAN;
BEGIN
    v_result := input_validation_pkg.validate_input('123', 'number');
    DBMS_OUTPUT.PUT_LINE('Is valid number: ' || v_result);

    v_result := input_validation_pkg.validate_input('Hello', 'text');
    DBMS_OUTPUT.PUT_LINE('Is valid text: ' || v_result);

    v_result := input_validation_pkg.validate_input('TRUE', 'boolean');
    DBMS_OUTPUT.PUT_LINE('Is valid boolean: ' || v_result);

    v_result := input_validation_pkg.validate_input('2023-10-01', 'date');
    DBMS_OUTPUT.PUT_LINE('Is valid date: ' || v_result);

    v_result := input_validation_pkg.validate_input('example@example.com', 'email');
    DBMS_OUTPUT.PUT_LINE('Is valid email: ' || v_result);

    v_result := input_validation_pkg.validate_input('+123-456-7890', 'phone');
    DBMS_OUTPUT.PUT_LINE('Is valid phone: ' || v_result);

    v_result := input_validation_pkg.validate_input('https://example.com', 'url');
    DBMS_OUTPUT.PUT_LINE('Is valid URL: ' || v_result);

    v_result := input_validation_pkg.validate_input('abc123', 'alphanumeric');
    DBMS_OUTPUT.PUT_LINE('Is valid alphanumeric: ' || v_result);

    v_result := input_validation_pkg.validate_input('password123', 'length');
    DBMS_OUTPUT.PUT_LINE('Is valid length: ' || v_result);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
```
Contributing
Contributions are welcome! If you have suggestions for improvements or additional features, feel free to open an issue or submit a pull request.

License
This project is licensed under the MIT License - see the LICENSE file for details.

Feel free to modify any part of the description to better fit your style or specific requirements!
