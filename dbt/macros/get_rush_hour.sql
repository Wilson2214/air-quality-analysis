{#
    This macro returns the description of the payment_type 
#}

{% macro get_rush_hour(hour_day) -%}

    case {{ dbt.safe_cast("hour_day", api.Column.translate_type("integer")) }}  
        when 6 then 'Rush Hour'
        when 7 then 'Rush Hour'
        when 8 then 'Rush Hour'
        when 9 then 'Rush Hour'
        when 10 then 'Rush Hour'
        when 15 then 'Rush Hour'
        when 16 then 'Rush Hour'
        when 17 then 'Rush Hour'
        when 18 then 'Rush Hour'
        when 19 then 'Rush Hour'
        else 'Non-Rush Hour'
    end

{%- endmacro %}