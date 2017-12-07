view: groups {
  sql_table_name: zendesk.groups_view ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: cast(${TABLE}.id as int64);;
  }

  dimension_group: created_at {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at ;;
  }

  #   - dimension: deleted
  #     type: yesno
  #     sql: ${TABLE}.deleted

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
