namespace: stuff
flow:
  name: create_csv_report
  inputs:
    - stockList:
        prompt:
          type: text
    - json_Stock_List: '[]'
  workflow:
    - list_iterator:
        do:
          io.cloudslang.base.lists.list_iterator:
            - list: '${stockList}'
        publish:
          - stockTicker: '${result_string}'
        navigate:
          - HAS_MORE: getStockPrice
          - NO_MORE: convert_JSON_to_CSV
          - FAILURE: on_failure
    - getStockPrice:
        do:
          stuff.getStockPrice:
            - stockTicker: '${stockTicker}'
        publish:
          - stock_info
        navigate:
          - FAILURE: on_failure
          - SUCCESS: add_object_into_json_array
    - add_object_into_json_array:
        do:
          io.cloudslang.base.json.add_object_into_json_array:
            - json_array: '${json_Stock_List}'
            - json_object: '${stock_info}'
            - index: '0'
        publish:
          - json_Stock_List: '${return_result}'
        navigate:
          - SUCCESS: list_iterator
          - FAILURE: on_failure
    - convert_JSON_to_CSV:
        do:
          stuff.convert_JSON_to_CSV:
            - json_object: '${json_Stock_List}'
        navigate:
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      list_iterator:
        x: 80
        'y': 80
      getStockPrice:
        x: 80
        'y': 240
      add_object_into_json_array:
        x: 280
        'y': 240
      convert_JSON_to_CSV:
        x: 320
        'y': 80
        navigate:
          984cb36c-adda-b53b-c710-d7dc552c8232:
            targetId: 1ec26ced-5ca8-2416-f72b-96bfd92571e8
            port: SUCCESS
    results:
      SUCCESS:
        1ec26ced-5ca8-2416-f72b-96bfd92571e8:
          x: 640
          'y': 80
