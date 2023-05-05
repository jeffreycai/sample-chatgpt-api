#!/bin/env python3
import os
import openai
from dotenv import load_dotenv

load_dotenv(dotenv_path='../.env')
openai.api_key = os.getenv("OPENAI_API_KEY")

response = openai.ChatCompletion.create(
    model="gpt-4", # gpt-4
    messages=[
            # a system message helps to set the behavior of the assistant
            {"role": "system", "content": "You are a chatbot"},

            # a user message helps to instruct the assistant
            {"role": "user", "content": "Just say 'Hello world', nothing else"},

            # an "assistant" message is what's returned, 
            # and used when providing the overall context of the conversation
            # when it's passed into the `messages` array in the request
            {"role": "assistant", "content": "Hello world!"},

            {"role": "user", "content": "Are you gpt3 or gpt4?"},
        ]
)

result = ''
for choice in response.choices:
    result += choice.message.content

print(result)
