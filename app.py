# Our goal is to make a recipe application that takes in a specific cuisine and generates a recipe and creative recipe name.

# create a function which takes in a cuisine and uses azure OPENAI to generate a recipe
# create a function which takes in a cuisine and uses azure OPENAI to generate a creative recipe name

# import libraries
from fastapi import FastAPI
import os
import requests
import json
import random


# import openai package and use it's python sdk to initialize the client and send a code completion request
import openai
openai.api_key = os.environ["OPENAI_API_KEY"]
# set the openai type to azure
openai.api_type = "azure"
# set the openai api_base to the custom deployed Azure OPENAI base url
openai.api_base = "https://generative-applications.openai.azure.com/"
# set the openai api_version to 2022-12-01
openai.api_version = "2022-12-01"

# set the deployment name to the name you gave to the deployed model. (Note: had to set manually)
deployment_name = "text-davinci-003"

# create the function to generate a recipe using a cuisine using the openai client. Dont forget to use the deployment name as the engine.
# use the openai client.


def generate_recipe(cuisine):
    # create the request body
    response = openai.Completion.create(
        engine=deployment_name,
        prompt=f"Recipe for {cuisine}:",
        temperature=0.7,
        max_tokens=100,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0
    )

    # return the response
    return response.choices[0].text


# create the function to generate a creative recipe name from the generated recipe
def generate_creative_recipe_name(recipe):
    # create the request body
    response = openai.Completion.create(
        engine=deployment_name,
        prompt=f"Creative Recipe Name for {recipe}:",
        temperature=0.7,
        max_tokens=100,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0
    )

    # return the response
    return response.choices[0].text

# Structure the recipe output in bullets and points and add a brief introduction.
# Use azure OPENAI for it.


def structure_recipe(recipe):
    # create the request body
    response = openai.Completion.create(
        engine=deployment_name,
        prompt=f"Structure Recipe for {recipe}:",
        temperature=0.7,
        max_tokens=100,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0
    )

    # return the response
    return response.choices[0].text


# create a fast api app and add a route to it to create recipes.
# return as a response a JSON object containing the creative recipe name
# and the structure.
# use the functions you created above to generate the recipe and creative recipe name.
# start:
# create a fast api app
app = FastAPI()

# add a route to it to create recipes from a recipe provided by the user.


@app.get("/recipe/{cuisine}")
async def create_recipe(cuisine: str):
    # get the recipe
    recipe = generate_recipe(cuisine)
    # get the creative recipe name
    creative_recipe_name = generate_creative_recipe_name(recipe)
    # get the structured recipe
    structured_recipe = structure_recipe(recipe)
    # return the response
    return {"creative_recipe_name": creative_recipe_name, "structured_recipe": structured_recipe}

# run the application on port 8000
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
