{% macro clean_is_active(column_name) %}

CASE
    WHEN LOWER(TRIM({{ column_name }})) = 'y' THEN TRUE
    ELSE FALSE
END

{% endmacro %}