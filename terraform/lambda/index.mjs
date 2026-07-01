import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, UpdateCommand } from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});
const docClient = DynamoDBDocumentClient.from(client);

export const handler = async (event) => {
  try {
    const command = new UpdateCommand({
      TableName: process.env.TABLE_NAME,
      Key: {
        id: "visitor-count",
      },
      UpdateExpression: "ADD #count :inc",
      ExpressionAttributeNames: {
        "#count": "count",
      },
      ExpressionAttributeValues: {
        ":inc": 1,
      },
      ReturnValues: "UPDATED_NEW",
    });

    const result = await docClient.send(command);

    return {
      statusCode: 200,
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        count: result.Attributes.count,
      }),
    };
  } catch (error) {
    console.error(error);

    return {
      statusCode: 500,
      body: JSON.stringify({
        error: error.message,
      }),
    };
  }
};