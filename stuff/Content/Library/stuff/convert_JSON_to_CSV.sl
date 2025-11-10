namespace: stuff
operation:
  name: convert_JSON_to_CSV
  inputs:
    - json_object
  python_action:
    use_jython: false
    script: "# do not remove the execute function\ndef execute(json_object):\n    # code goes here\n# you can add additional helper methods below.\n    import json \n    import csv\n    import io\n\n\n\n    if isinstance(json_object, str):\n        data = json.loads(json_object)\n    else:\n        data = json_object\n\n    if not data:\n        return \"\"\n\n    # Determine fieldnames (headers) from the first dictionary in the list\n    fieldnames = data[0].keys()\n\n    # Create an in-memory text buffer\n    output_buffer = io.StringIO()\n\n    # Create a CSV writer that writes to the in-memory buffer\n    writer = csv.DictWriter(output_buffer, fieldnames=fieldnames)\n\n    # Write the header row\n    writer.writeheader()\n\n    # Write the data rows\n    writer.writerows(data)\n\n    # Get the CSV string from the buffer\n    csv_string = output_buffer.getvalue()\n    \n    return {\"output\" : csv_string}"
  outputs:
    - output
  results:
    - SUCCESS
