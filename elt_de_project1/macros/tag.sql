{% macro tag(column) %}
    CASE
        WHEN {{ column }} < 100 THEN 'LOW'
        WHEN {{ column }} < 200 THEN 'MEDIUM'
        ELSE 'HIGH'
    END
{% endmacro %}