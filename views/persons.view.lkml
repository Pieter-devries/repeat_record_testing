view: persons {

  sql_table_name: bigquery-samples.nested.persons_living ;;

  dimension: id {
    primary_key: yes
    sql: ${TABLE}.fullName ;;
  }

  dimension: fullName {label: "Full Name"}

  dimension: kind {}

  dimension: age {type:number}

  dimension: citiesLived {hidden:yes}

  dimension: phoneNumber {hidden:yes}

  measure: average_age {
    type: average
    sql: ${age} ;;
    drill_fields: [fullName,age]
  }

  measure: count {
    type: count
    drill_fields: [fullName, cities_lived.place_count, age]
  }
}

view: persons_phone_number {

  dimension: areaCode {label: "Area Code"}

  dimension: number {}
}

view: persons_cities_lived {

  dimension: id {
    primary_key: yes
    sql: CONCAT(CAST(${persons.fullName} AS STRING),'|', CAST(${place} AS STRING)) ;;
  }

  dimension: place {}

  dimension: numberOfYears {
    label: "Number Of Years"
    type: number
  }

  measure: place_count {
    type: count
    drill_fields: [place, persons.count]
  }

  measure: total_years {
    type: sum
    sql: ${numberOfYears} ;;
    drill_fields: [persons.fullName, persons.age, place, numberOfYears]
  }

}
