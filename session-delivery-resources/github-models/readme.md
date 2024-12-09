# Demo 5: Github Models

#### Description   
In this demo you are going to show how you can use GitHub models quickly to create an insurance report from a video.

#### Required access and products
- Access to [models in the Marketplace](https://github.com/marketplace/models)

#### Running the notebook
- Start a codespace from the repository
- browse to the notebook in session-delivery-resources/github-models/insurance-assistant.ipynb
- Run the notebook (select the Python 3.11 Kernel)

## Demo walkthrough

- [Backup video recording](https://aka.ms/AArvo1o)
- [Demo files](https://github.com/microsoft/aitour-generative-ai-in-azure/tree/main/session-delivery-resources/github-models)

### Part 1 - Playground & System message
- Go to GitHub.com and login with your github account
- Navigate to the [Model in the Marketplace](https://github.com/marketplace/models)
- Click on playground    
    - Select GPT-4o Mini
    - System message: You are a grumpy assistant, only answering questions about the rubber ducks
    - In the user message type: "Hello"
    - Change the models and see how they respond differently

### Part 2 - Azure AI Inference SDK
- Navigate to a model in the [Model in the Marketplace](https://github.com/marketplace/models)
- Click on: Get Started (Discuss the different options)
- Open "insurance-assistant.ipynb" in the running codespace
- Run and discuss the cells
    - 1 - Extract 14 frames from the video
    - 2 - Send the frames + prompt to the model using the Azure AI Inference SDK
    - 3 - Discuss the models output
