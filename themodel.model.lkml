connection: "kentomine"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }


explore: persons {
  #Repeated nested object
  join: persons_cities_lived {
    view_label: "Persons: Cities Lived:"
    sql: LEFT JOIN UNNEST(persons.citiesLived) as persons_cities_lived ;;
    relationship: one_to_many
  }
  #Non repeated nested object
  join: persons_phone_number {
    view_label: "Persons: Phone:"
    sql: LEFT JOIN UNNEST([${persons.phoneNumber}]) as persons_phone_number ;;
    relationship: one_to_one
  }
}

explore: person2 {
  view_name: persons
}
