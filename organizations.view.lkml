view: organizations {
  sql_table_name: zendesk.organizations_view ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: cast( ${TABLE}.id as int64) ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at ;;
  }

  dimension: details {
    type: string
    sql: ${TABLE}.details ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: shared_comments {
    type: yesno
    sql: ${TABLE}.shared_comments ;;
  }

  dimension: shared_tickets {
    type: yesno
    sql: ${TABLE}.shared_tickets ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
