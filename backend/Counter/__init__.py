import logging

import azure.functions as func
from azure.data.tables import TableServiceClient, TableClient, UpdateMode
from datetime import datetime
import os


def main(req: func.HttpRequest, doc: func.Out[func.Document]) -> func.HttpResponse:

    connection_string = os.environ["CosmosDBConnectionString"]
    table_service_client = TableServiceClient.from_connection_string(conn_str=connection_string)

    table_name = os.environ["CosmosDBTable"]


    table_client = table_service_client.get_table_client(table_name=table_name)

    output = {}

    my_filter = "PartitionKey eq 'visitor'"
    entities = table_client.query_entities(my_filter)
    for entity in entities:
        for key in entity.keys():
            output["{}".format(key)] = "{}".format(entity[key])

    output.update({"Count": (int(output["Count"]) + 1)})

    table_client.update_entity(mode=UpdateMode.REPLACE, entity=output)

    return "{}".format(output)