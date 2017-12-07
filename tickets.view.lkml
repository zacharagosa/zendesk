view: tickets {
  sql_table_name: zendesk.tickets_view ;;

  set: ticket_drill {
    fields: [id, assignee_email,  created_at_date, is_open, subject, requester_email]
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    link: {
      label: "View ticket {{ value }} in Zendesk"
      url: "https://zen-marketing-documentation.s3.amazonaws.com/docs/en/gsg_new_ticket_comment3.png"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  dimension: assignee_email {
    description: "the requester is the customer who initiated the ticket. the email is retrieved from the `users` table."
    sql: ${assignees.email} ;;
    action: {
      label: "Send Zendesk Followup Email"
      url: "https://desolate-refuge-53336.herokuapp.com/posts"
      icon_url: "https://sendgrid.com/favicon.ico"
      form_param: {
        name: "Subject"
        type: string
        required:  yes
        default: "Following Up on Your Chat Support Conversation"
      }
      form_param: {
        name: "Body"
        type: textarea
        required: yes
        default:
        "Hey Team,

        I saw that you reached out to our support team. Is there anything I can do to help?

        Thanks,
        John Smith
        Manager | Customer Success"
      }
      form_param: {
        name: "Send Me a Copy"
        type: select
        default: "yes"
        option: {
          name: "yes"
          label: "yes"
        }
      }
    }
  }

  ## include only if your Zendesk application utilizes the assignee_id field
  dimension: assignee_id {
    type: string
    value_format_name: id
    sql: cast(${TABLE}.assignee_id as int64);;
  }

  #   - dimension: brand_id      ## include only if your Zendesk application utilizes the brand field
  #     value_format_name: id                ## only associated with Zendesk Enterprise Accounts
  #     type: number
  #     sql: ${TABLE}.brand_id

  dimension_group: created_at {
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.created_at;;
  }

  dimension: ticket_age {
    type: number
    sql: DATE_DIFF(CURRENT_DATE(),${created_at_date}, day) ;;
  }
  dimension: ticket_age_tier {
    label: "Ticket Age Tier (days)"
    type: tier
    tiers: [0, 1,7, 14, 21]
    style: integer
    sql: ${ticket_age};;
  }


  dimension: group_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.group_id ;;
  }

  dimension: organization_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.organization_id ;;
  }

  dimension: organization_name {
    type: string
    sql: ${organizations.name} ;;
  }

  dimension: recipient {
    type: string
    sql: ${TABLE}.recipient ;;
  }

  dimension: requester_email {
    description: "the requester is the customer who initiated the ticket. the email is retrieved from the `users` table."
    sql: ${requesters.email} ;;
  }

  dimension: requester_id {
    description: "the requester is the customer who initiated the ticket"
    type: number
    value_format_name: id
    sql: cast(${TABLE}.requester_id as int64) ;;
  }


  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  ## depending on use, either this field or "via_channel" will represent the channel the ticket came through
  dimension: subject {
    type: string
    sql: ${TABLE}.subject ;;
  }

  ## The submitter is always the first to comment on a ticket
  dimension: submitter_id {
    description: "a submitter is either a customer or an agent submitting on behalf of a customer"
    type: number
    value_format_name: id
    sql: ${TABLE}.submitter_id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: via_channel {
    type: string
    sql: ${TABLE}.subject ;;
  }

  measure: count {
    type: count
    drill_fields: [ticket_drill*]
  }

  # ----- ADDITIONAL FIELDS -----

  dimension: is_backlogged {
    type: yesno
    sql: ${status} = 'pending' ;;
  }

  dimension: is_new {
    type: yesno
    sql: ${status} = 'new' ;;
  }

  dimension: is_open {
    type: yesno
    sql: ${status} = 'open' ;;
  }

  dimension: is_solved {
    description: "solved tickets have either a solved or closed status"
    type: yesno
    sql: ${status} = 'solved' OR ${status} = 'closed' ;;
  }

  dimension: subject_category {
    sql: CASE
      WHEN ${subject} LIKE 'Chat%' THEN 'Chat'
      WHEN ${subject} LIKE 'Offline message%' THEN 'Offline Message'
      WHEN ${subject} LIKE 'Phone%' THEN 'Phone Call'
      ELSE 'Other'
      END
       ;;
  }

  measure: count_pending_tickets {
    type: count

    filters: {
      field: is_backlogged
      value: "Yes"
    }
    drill_fields: [ticket_drill*]
  }

  measure: count_new_tickets {
    type: count

    filters: {
      field: is_new
      value: "Yes"
    }
    drill_fields: [ticket_drill*]
  }

  measure: count_open_tickets {
    type: count

    filters: {
      field: is_open
      value: "Yes"
    }
    drill_fields: [ticket_drill*]
  }

  measure: count_solved_tickets {
    type: count

    filters: {
      field: is_solved
      value: "Yes"
    }
    drill_fields: [ticket_drill*]
  }

  measure: count_distinct_organizations {
    type: count_distinct
    sql: ${organization_id} ;;
  }

  measure: count_orgs_submitting {
    type: count_distinct
    sql: ${organizations.name} ;;

    filters: {
      field: organization_name
      value: "-NULL"
    }
  }

  ############ TIME FIELDS ###########

  dimension_group: time {
    type: time
    ###   use day_of_week
    timeframes: [day_of_week, hour_of_day]
    sql: ${TABLE}.created_at ;;
  }
}

#   - dimension: created_day_of_week
#     sql_case:
#       Sunday:    ${hidden_created_day_of_week_index} = 6
#       Monday:    ${hidden_created_day_of_week_index} = 0
#       Tuesday:   ${hidden_created_day_of_week_index} = 1
#       Wednesday: ${hidden_created_day_of_week_index} = 2
#       Thursday:  ${hidden_created_day_of_week_index} = 3
#       Friday:    ${hidden_created_day_of_week_index} = 4
#       Saturday:  ${hidden_created_day_of_week_index} = 5

### REVIEW
#   - dimension: satisfaction_rating_percent_tier
#     type: tier
#     tiers: [10,20,30,40,50,60,70,80,90]
#     sql: ${satisfaction_rating}
#
#   - measure: average_satisfaction_rating
#     type: avg
#     sql: ${satisfaction_rating}
#     value_format: '#,#00.00%'


### REVIEW BELOW
# ----- Sets of fields for drilling ------
#   sets:
#     detail:
#     - via__source__from__ticket_id
#     - via__source__from__name
#     - via__source__to__name
#     - organizations.id
#     - organizations.name
#     - audits.count
#     - zendesk_ticket_metrics.count
