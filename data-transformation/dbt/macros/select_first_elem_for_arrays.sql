{% macro select_first_elem_for_arrays(relation, exclude=[]) %}
  {% set cols = adapter.get_columns_in_relation(relation) %}

  {%- for col in cols %}
    {%- set col_name = col.name %}
    {%- set col_type = (col.data_type or '') | upper %}

    {%- if col_name not in exclude %}
      {%- if col_type.startswith('ARRAY') %}
        {{ col_name }}[SAFE_OFFSET(0)] as {{ col_name }}
      {%- else %}
        {{ col_name }}
      {%- endif %}
      {{ "," if not loop.last }}
    {%- endif %}
  {%- endfor %}
{% endmacro %}