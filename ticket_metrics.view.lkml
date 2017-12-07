view: ticket_metrics {
  sql_table_name: zendesk.ticket_metrics_view ;;
  #   definition resource: https://developer.zendesk.com/rest_api/docs/core/ticket_metrics

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: agent_wait_time_in_minutes_business {
    type: number
    sql: ${TABLE}.agent_wait_time_in_minutes_business ;;
  }

  dimension: agent_wait_time_in_minutes_calendar {
    type: number
    sql: ${TABLE}.agent_wait_time_in_minutes_calendar ;;
  }

  dimension_group: assigned {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.assigned_at ;;
  }

  dimension: assignee_id {
    type: number
    sql: ${tickets.assignee_id} ;;
  }

  dimension: assignee_email {
    type: string
    sql: ${users.email} ;;
  }

  dimension: group_name {
    type: string
    sql: ${groups.name} ;;
  }

  dimension_group: assignee_updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.assignee_updated_at ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at ;;
  }

  dimension: organization_name {
    type: string
    sql: ${tickets.organization_name} ;;
  }

  # MINUTES

  dimension: first_resolution_time_in_minutes_business {
    type: number
    sql: ${TABLE}.first_resolution_time_in_minutes_business ;;
  }

  measure: avg_first_resolution_time_in_minutes_business {
    type: average
    sql: ${first_resolution_time_in_minutes_business} ;;
  }

  #   - dimension: first_resolution_time_in_minutes_calendar
  #     type: number
  #     sql: ${TABLE}.first_resolution_time_in_minutes_calendar
  #
  #   - measure: avg_first_resolution_time_in_minutes_calendar
  #     type: avg
  #     sql: ${first_resolution_time_in_minutes_calendar}

  dimension: full_resolution_time_in_minutes_business {
    type: number
    sql: ${TABLE}.full_resolution_time_in_minutes_business ;;
  }

  measure: avg_full_resolution_time_in_minutes_business {
    type: average
    sql: ${full_resolution_time_in_minutes_business} ;;
    value_format_name: decimal_2
  }

  #   - dimension: full_resolution_time_in_minutes_calendar
  #     type: number
  #     sql: ${TABLE}.full_resolution_time_in_minutes_calendar
  #
  #   - measure: avg_full_resolution_time_in_minutes_calendar
  #     type: avg
  #     sql: ${full_resolution_time_in_minutes_calendar}


  # HOURS

  dimension: first_resolution_time_in_hours_business {
    type: number
    sql: (${TABLE}.first_resolution_time_in_minutes_business / 60) ;;
  }

  measure: avg_first_resolution_time_in_hours_business {
    type: average
    sql: ${first_resolution_time_in_hours_business} ;;
    value_format_name: decimal_2
  }

  #   - dimension: first_resolution_time_in_hours_calendar
  #     type: number
  #     sql: ${TABLE}.first_resolution_time_in_minutes_calendar / 60
  #
  #   - measure: avg_first_resolution_time_in_hours_calendar
  #     type: avg
  #     sql: ${first_resolution_time_in_hours_calendar}

  dimension: full_resolution_time_in_hours_business {
    type: number
    sql: ${TABLE}.full_resolution_time_in_minutes_business / 60 ;;

  }

  measure: avg_full_resolution_time_in_hours_business {
    type: average
    sql: ${full_resolution_time_in_hours_business} ;;
    value_format_name: decimal_2
  }

  #   - dimension: full_resolution_time_in_hours_calendar
  #     type: number
  #     sql: ${TABLE}.full_resolution_time_in_minutes_calendar / 60
  #
  #   - measure: avg_full_resolution_time_in_hours_calendar
  #     type: avg
  #     sql: ${full_resolution_time_in_minutes_calendar}


  # DAYS

  dimension: first_resolution_time_in_days_business {
    type: number
    sql: ${TABLE}.first_resolution_time_in_minutes_business / 480 ;;
  }

  measure: avg_first_resolution_time_in_days_business {
    type: average
    sql: ${first_resolution_time_in_days_business} ;;
    value_format_name: decimal_2
  }

  #   - dimension: first_resolution_time_in_days_calendar
  #     type: number
  #     sql: ${TABLE}.first_resolution_time_in_minutes_calendar / 1440
  #
  #   - measure: avg_first_resolution_time_in_days_calendar
  #     type: avg
  #     sql: ${first_resolution_time_in_days_calendar}

  dimension: full_resolution_time_in_days_business {
    type: number
    sql: ${TABLE}.full_resolution_time_in_minutes_business / 480 ;;
  }

  measure: avg_full_resolution_time_in_days_business {
    type: average
    sql: ${full_resolution_time_in_days_business} ;;
    value_format_name: decimal_2
  }

  #   - dimension: full_resolution_time_in_days_calendar
  #     type: number
  #     sql: ${TABLE}.full_resolution_time_in_minutes_calendar / 1440
  #
  #   - measure: avg_full_resolution_time_in_days_calendar
  #     type: avg
  #     sql: ${full_resolution_time_in_days_calendar}


  dimension_group: initially_assigned {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.initially_assigned_at ;;
  }

  dimension_group: latest_comment_added {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.latest_comment_added_at ;;
  }

  #   - dimension: on_hold_time_in_minutes_business
  #     type: number
  #     sql: ${TABLE}.on_hold_time_in_minutes_business
  #
  #   - dimension: on_hold_time_in_minutes_calendar
  #     type: number
  #     sql: ${TABLE}.on_hold_time_in_minutes_calendar

  dimension: reopens {
    type: number
    sql: ${TABLE}.reopens ;;
  }

  dimension: replies {
    type: number
    sql: ${TABLE}.replies ;;
  }

  # FIRST REPLY MINUTES

  dimension: reply_time_in_minutes_business {
    type: number
    sql: ${TABLE}.reply_time_in_minutes_business ;;
  }

  measure: avg_reply_time_in_minutes_business {
    type: average
    sql: ${reply_time_in_minutes_business} ;;
    value_format_name: decimal_2
  }

  #   - dimension: reply_time_in_minutes_calendar
  #     type: number
  #     sql: ${TABLE}.reply_time_in_minutes_calendar
  #
  #   - measure: avg_reply_time_in_minutes_calendar
  #     type: avg
  #     sql: ${reply_time_in_minutes_calendar}


  # FIRST REPLY HOURS

  dimension: reply_time_in_hours_business {
    type: number
    sql: ${TABLE}.reply_time_in_minutes_business / 60 ;;
  }

  measure: avg_reply_time_in_hours_business {
    type: average
    sql: ${reply_time_in_hours_business} ;;
    value_format_name: decimal_2
  }

  #   - dimension: reply_time_in_hours_calendar
  #     type: number
  #     sql: ${TABLE}.reply_time_in_minutes_calendar / 60
  #
  #   - measure: avg_reply_time_in_hours_calendar
  #     type: avg
  #     sql: ${reply_time_in_hours_calendar}

  dimension_group: requester_updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.requester_updated_at ;;
  }

  dimension: requester_wait_time_in_minutes_business {
    type: number
    sql: ${TABLE}.requester_wait_time_in_minutes_business ;;
  }

  #   - dimension: requester_wait_time_in_minutes_calendar
  #     type: number
  #     sql: ${TABLE}.requester_wait_time_in_minutes_calendar

  dimension_group: solved {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.solved_at ;;
  }

  dimension_group: status_updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.status_updated_at ;;
  }

  dimension: ticket_id {
    type: number
    # hidden: true
    sql: ${TABLE}.ticket_id ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at ;;
  }

  measure: count {
    type: count
    drill_fields: [id, tickets.via_source_from_name, tickets.id, tickets.via_source_to_name]
  }
}
