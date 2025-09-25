# 💳 PAN Card Validation SQL Project
<p align="center">
  <strong style="font-size:20px">💳 PAN Card Validation</strong><br>
  <em>SQL toolkit & queries for PAN validation and reporting</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/SQL-ready-blue" alt="SQL ready" />
  <img src="https://img.shields.io/badge/format-PAN-orange" alt="PAN format" />
  <img src="https://img.shields.io/github/license/your-username/your-repo" alt="license" />
</p>

## Project Overview 🎯
This project focuses on **data cleaning and validation of Permanent Account Numbers (PAN)** for Indian nationals using SQL. The primary goal is to process a dataset of PAN numbers, ensure they adhere to official formats and rules, and categorize them as either **valid** or **invalid**. The project also includes generating comprehensive reports on the validation status.

This solution was developed following the methodology outlined in the YouTube video: [PAN Card Validation in SQL | Real World Data Cleaning & Validation Project](https://www.youtube.com/watch?v=J1vlhH5LFY8).

---

## Background: What is a PAN Number? 🇮🇳
A Permanent Account Number (PAN) is a **10-digit unique identifier** issued to Indian taxpayers by the Income Tax Department. It is essential for various financial transactions and tax filings in India. The PAN follows a specific alphanumeric format, and this project aims to validate entries against these official guidelines.

---

## Project Objectives 📝
* **Data Cleaning:** Identify and handle missing values, duplicates, leading/trailing spaces, and incorrect letter cases within the PAN dataset.
* **Format Validation:** Ensure each PAN number adheres to the official 10-character alphanumeric format.
* **Rule-Based Validation:** Implement complex validation rules including:
    * No adjacent repeating characters in the first five alphabets.
    * First five alphabets do not form a sequential series (e.g., ABCDE).
    * No adjacent repeating digits in the next four numbers.
    * Next four digits do not form a sequential series (e.g., 1234).
* **Categorization:** Classify each processed PAN number as 'Valid PAN' or 'Invalid PAN'.
* **Reporting:** Generate two types of reports:
    1.  A detailed report listing all processed PAN numbers with their validation status.
    2.  A summary report providing counts of total records processed, total valid PANs, total invalid PANs, and total missing/incomplete PANs.

---

## Technologies Used 🛠️
* **Database:** PostgreSQL (for table creation, data import, and SQL queries)
* **Language:** SQL (specifically PostgreSQL syntax for functions, regular expressions, and queries)
* **Tool:** pgAdmin (for database interaction, table creation, and data import)
* **Data Source:** Excel/CSV file containing raw PAN numbers.

---

## PAN Number Structure & Validation Rules 📋

### Official Format
A PAN number is a 10-character alphanumeric string with the following structure:
`[AAAAA][DDDD][A]`
* **First five characters:** Alphabets (A-Z)
* **Next four characters:** Digits (0-9)
* **Last character:** Alphabet (A-Z)

### Data Cleaning Rules (Pre-processing)
1.  **Handle Missing Data:** Remove records with `NULL` or entirely blank PAN numbers.
2.  **Remove Duplicates:** Ensure each PAN number is unique.
3.  **Trim Spaces:** Remove leading and trailing spaces from PAN entries .
4.  **Correct Letter Case:** Convert all PAN numbers to uppercase.

### Validation Rules (Post-cleaning)
1.  **Length Check:** PAN must be exactly 10 characters long. (Handled implicitly by regex pattern matching) .
2.  **Pattern Match:** Adhere to the `[AAAAA][DDDD][A]` format using regular expressions .
3.  **First Five Alphabets Rules:**
    * **No Adjacent Same Characters:** E.g., `AABCD` is invalid, `AXBCD` is valid.
    * **No Sequential Characters:** E.g., `ABCDE` is invalid, `ABCDX` is valid.
4.  **Next Four Digits Rules:**
    * **No Adjacent Same Digits:** E.g., `1123` is invalid, `1923` is valid .
    * **No Sequential Digits:** E.g., `1234` is invalid, `1239` is valid.
5.  **Last Character:** Must be an uppercase alphabet.

---

## Implementation Details 💻

### Database Setup
1.  **Create Table:** A staging table `STG_PAN_NUMBERS_DATASET` is created in PostgreSQL with a single `pan_number` column (TEXT type).
    ```sql
    CREATE TABLE STG_PAN_NUMBERS_DATASET (
        pan_number TEXT
    );
    ```
2.  **Import Data:** The raw PAN data (initially in Excel) is converted to CSV format and imported into the `STG_PAN_NUMBERS_DATASET` table .

### SQL Queries & Functions

#### 1. Data Cleaning CTE (`CTE_CLEANED_PAN`)
This Common Table Expression (CTE) consolidates all cleaning steps:
* Removes `NULL` PANs .
* Removes duplicate PANs using `DISTINCT`.
* Trims leading/trailing spaces using `TRIM()` and removes empty strings .
* Converts all PANs to uppercase using `UPPER()`.
#### 2. User-Defined Functions (UDFs) for Complex Validations
Two PostgreSQL functions were created to handle the adjacent and sequential character/digit rules:

* **`fn_check_adjacent_characters(p_string_str TEXT)`** 
    * **Purpose:** Checks if any two adjacent characters in a given string are the same.
    * **Returns:** `TRUE` if adjacent characters are the same (indicating invalidity), `FALSE` otherwise.
    * **Logic:** Loops through the string, comparing `SUBSTRING(p_string_str, i, 1)` with `SUBSTRING(p_string_str, i+1, 1)`.

    ```sql
    CREATE OR REPLACE FUNCTION fn_check_adjacent_characters(p_string_str TEXT)
    RETURNS BOOLEAN
    LANGUAGE plpgsql
    AS $$
    DECLARE
        i INT;
    BEGIN
        FOR i IN 1 .. LENGTH(p_string_str) - 1 LOOP
            IF SUBSTRING(p_string_str, i, 1) = SUBSTRING(p_string_str, i + 1, 1) THEN
                RETURN TRUE; -- Adjacent characters are the same
            END IF;
        END LOOP;
        RETURN FALSE; -- None of the adjacent characters are the same
    END;
    $$;
    ```

* **`fn_check_sequential_characters(p_string_str TEXT)`** 
    * **Purpose:** Checks if all characters in a given string form a sequential series (e.g., ABCDE, 1234).
    * **Returns:** `TRUE` if characters are sequential (indicating invalidity), `FALSE` otherwise.
    * **Logic:** Compares the ASCII values of adjacent characters. If `ASCII(SUBSTRING(p_string_str, i + 1, 1)) - ASCII(SUBSTRING(p_string_str, i, 1))` is always `1` for all adjacent pairs, it's sequential.

    ```sql
    CREATE OR REPLACE FUNCTION fn_check_sequential_characters(p_string_str TEXT)
    RETURNS BOOLEAN
    LANGUAGE plpgsql
    AS $$
    DECLARE
        i INT;
    BEGIN
        FOR i IN 1 .. LENGTH(p_string_str) - 1 LOOP
            IF ASCII(SUBSTRING(p_string_str, i + 1, 1)) - ASCII(SUBSTRING(p_string_str, i, 1)) != 1 THEN
                RETURN FALSE; -- Characters are not sequential
            END IF;
        END LOOP;
        RETURN TRUE; -- All characters are sequential
    END;
    $$;
    ```

#### 3. Regular Expression for PAN Pattern Validation
The core PAN format `[AAAAA][DDDD][A]` is validated using a regular expression [00:33:03]:
* `^[A-Z]{5}[0-9]{4}[A-Z]{1}$`
    * `^`: Start of the string.
    * `[A-Z]{5}`: Exactly five uppercase alphabets.
    * `[0-9]{4}`: Exactly four digits.
    * `[A-Z]{1}`: Exactly one uppercase alphabet.
    * `$`: End of the string.

#### 4. Valid and Invalid PAN Categorization (View `VIEW_VALID_INVALID_PANS`)
A PostgreSQL `VIEW` is created to encapsulate the full validation logic and categorize each cleaned PAN:
* It starts with the `CTE_CLEANED_PAN` [00:40:13].
* Applies the regular expression pattern match.
* Calls `fn_check_adjacent_characters` for the first 5 alphabets (substring 1, 5) and the 4 digits (substring 6, 4).
* Calls `fn_check_sequential_characters` for the first 5 alphabets (substring 1, 5) and the 4 digits (substring 6, 4).
* A `CASE` statement assigns 'Valid PAN' if all conditions are met, otherwise 'Invalid PAN'.

    ```sql
    -- Example structure of the view (simplified for brevity, full logic uses the UDFs and regex)
    CREATE OR REPLACE VIEW VIEW_VALID_INVALID_PANS AS
    WITH CTE_CLEANED_PAN AS (
        SELECT DISTINCT
               UPPER(TRIM(pan_number)) AS pan_number
        FROM STG_PAN_NUMBERS_DATASET
        WHERE pan_number IS NOT NULL
          AND TRIM(pan_number) != ''
          AND UPPER(TRIM(pan_number)) = TRIM(pan_number) -- Ensure already uppercase
    ),
    CTE_VALID_PAN_CHECKS AS (
        SELECT
            pan_number
        FROM CTE_CLEANED_PAN
        WHERE
            pan_number ~ '^[A-Z]{5}[0-9]{4}[A-Z]{1}$' -- Main Regex Pattern
            AND NOT fn_check_adjacent_characters(SUBSTRING(pan_number, 1, 5))
            AND NOT fn_check_sequential_characters(SUBSTRING(pan_number, 1, 5))
            AND NOT fn_check_adjacent_characters(SUBSTRING(pan_number, 6, 4))
            AND NOT fn_check_sequential_characters(SUBSTRING(pan_number, 6, 4))
    )
    SELECT
        c.pan_number,
        CASE
            WHEN v.pan_number IS NOT NULL THEN 'Valid PAN'
            ELSE 'Invalid PAN'
        END AS status
    FROM CTE_CLEANED_PAN c
    LEFT JOIN CTE_VALID_PAN_CHECKS v
           ON c.pan_number = v.pan_number;
    ```

#### 5. Summary Report Query
This query utilizes the `STG_PAN_NUMBERS_DATASET` table and `VIEW_VALID_INVALID_PANS` view to generate the final summary:
* `COUNT(*)` from `STG_PAN_NUMBERS_DATASET` for total processed records .
* `COUNT(*) FILTER (WHERE status = 'Valid PAN')` from the view for total valid PANs .
* `COUNT(*) FILTER (WHERE status = 'Invalid PAN')` from the view for total invalid PANs .
* Calculates missing/incomplete PANs by subtracting (valid + invalid) from total processed .

    ```sql
    WITH CTE_SUMMARY AS (
        SELECT
            (SELECT COUNT(*) FROM STG_PAN_NUMBERS_DATASET) AS total_processed_records,
            COUNT(*) FILTER (WHERE status = 'Valid PAN') AS total_valid_pans,
            COUNT(*) FILTER (WHERE status = 'Invalid PAN') AS total_invalid_pans
        FROM VIEW_VALID_INVALID_PANS
    )
    SELECT
        total_processed_records,
        total_valid_pans,
        total_invalid_pans,
        total_processed_records - (total_valid_pans + total_invalid_pans) AS total_missing_incomplete_pans
    FROM CTE_SUMMARY;
    ```
    * **Example Output of Summary Report (based on video data):**
        * Total Processed Records: `10,000`
        * Total Valid PANs: `3,186`
        * Total Invalid PANs: `5,839`
        * Total Missing/Incomplete PANs: `975`

---

## How to Use/Setup Locally 🚀

1.  **Database:** Install PostgreSQL and a client tool like pgAdmin.
2.  **Schema:** Create a new database (e.g., `YouTube`) and schema.
3.  **Table Creation:** Run the `CREATE TABLE STG_PAN_NUMBERS_DATASET` script.
4.  **Data Import:** Obtain the raw PAN data (from the video's description or create a sample CSV with a `pan_number` column), convert it to CSV, and import it into the `STG_PAN_NUMBERS_DATASET` table using pgAdmin's import functionality.
5.  **UDFs Creation:** Execute the `CREATE OR REPLACE FUNCTION` scripts for both `fn_check_adjacent_characters` and `fn_check_sequential_characters`.
6.  **View Creation:** Execute the `CREATE OR REPLACE VIEW VIEW_VALID_INVALID_PANS` script.
7.  **Run Reports:**
    * For the detailed report of all PANs with status:
        ```sql
        SELECT * FROM VIEW_VALID_INVALID_PANS;
        ```
    * For the summary report:
        ```sql
        -- Use the Summary Report Query provided above
        WITH CTE_SUMMARY AS (
            SELECT
                (SELECT COUNT(*) FROM STG_PAN_NUMBERS_DATASET) AS total_processed_records,
                COUNT(*) FILTER (WHERE status = 'Valid PAN') AS total_valid_pans,
                COUNT(*) FILTER (WHERE status = 'Invalid PAN') AS total_invalid_pans
            FROM VIEW_VALID_INVALID_PANS
        )
        SELECT
            total_processed_records,
            total_valid_pans,
            total_invalid_pans,
            total_processed_records - (total_valid_pans + total_invalid_pans) AS total_missing_incomplete_pans
        FROM CTE_SUMMARY;
        ```

---

## Future Enhancements ✨
* **Error Logging:** Implement detailed error logging for invalid PANs, indicating *why* a PAN was deemed invalid (e.g., "Invalid Length", "Adjacent Characters Found").
* **Performance Optimization:** For very large datasets, consider partitioning or indexing strategies.
* **Python Integration:** Extend the project to include a Python solution, as discussed in the video, potentially for comparison or to handle more complex data manipulation tasks.
* **Web Interface:** Develop a simple web application to allow users to upload files and view validation results.

---

## Contributing 🤝
Contributions are welcome! If you have suggestions for improvements, bug fixes, or new features, please open an issue or submit a pull request.

---

## License 📄

This project is open-source and available under the [MIT License](LICENSE).

