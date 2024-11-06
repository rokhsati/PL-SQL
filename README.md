# PL/SQL Input Validation Function
## Overview
This repository contains a PL/SQL function designed to validate user input based on specified types, including **number**, **text**, and **boolean**. The function not only checks the validity of the input against the expected type but also incorporates a basic SQL injection detection mechanism to enhance security.

## Features
Type Validation: The function accepts a user input value and checks if it matches the specified type:
- **Number**: Validates if the input can be converted to a numeric value.
- **Text**: Accepts any non-null string as valid text.
- **Boolean**: Validates if the input is either 'TRUE' or 'FALSE' (case-insensitive).
- **SQL Injection Protection**: The function includes checks for common SQL injection patterns, raising an error if potentially harmful input is detected.
## Usage
You can call the validate_input function in your PL/SQL blocks or procedures to ensure that user inputs are validated and safe from SQL injection attacks.

## Example

 ```sql
DECLARE
    v_result BOOLEAN;
BEGIN
    v_result := validate_input('123', 'number');
    DBMS_OUTPUT.PUT_LINE('Is valid number: ' || v_result);
    
    v_result := validate_input('Hello', 'text');
    DBMS_OUTPUT.PUT_LINE('Is valid text: ' || v_result);
    
    v_result := validate_input('TRUE', 'boolean');
    DBMS_OUTPUT.PUT_LINE('Is valid boolean: ' || v_result);
    
    -- This input should trigger the SQL injection check
    v_result := validate_input('1; DROP TABLE users;', 'number');
    DBMS_OUTPUT.PUT_LINE('Is valid number: ' || v_result);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
```

## Contributing
Contributions are welcome! If you have suggestions for improvements or additional features, feel free to open an issue or submit a pull request.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

Feel free to modify any part of the description to better fit your style or specific requirements!
