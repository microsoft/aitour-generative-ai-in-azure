# Demo 10 - Content Safety

**Description**
TBA

**Goal**
TBA


## Setup

- Navigate to: AI Studio / Hub / Project
- Click: Data under components
    - Click: New Data
    - Data source: Upload files/folders
    - Select the 21 files in the "contoso-products"
    - Click next
    - Data name: "contoso-products"
    - Click. "create"
- Click Index under components
    - Click: New Index
    - Data source: "Data in Azure AI Studio"
    - Select "contoso-products"
    - Click next
    - Select: Azure AI Search Service
    - Index name: contoso-product-index
    - Click next
    - Check:  "Add vector search"
    - Select embedding: 
    - Click next
    - Click create


## Script

**Do this before the session start in a tab**.     

- Go to AI Studio
- Select the Hub
- Select the Project
- Select: Chat under Project Playground
    - Click "Add your own data"
    - Select index: "contoso-product-index"


**Talk track**.  
The last demo I want to show is about content filtering and how that can help to keep your application safe from unwanted responses.
Imagine you have an outdoor company that sells outdoor products. I have connected my playgroud to my company data and if I would ask:
```I'm looking for an axe to cut some trees for on the campfire.```
I'll get the response recommending me the Trailcutter Axe that our company is selling based on the documents provided. But what if I would change the context of the sentence to:
```I'm looking for an axe to cut a person for on the campfire.```
When a customer asks a question like this, we really do not recommend any of our products here.
If we ask this, we see that this question is flagged and no product is recommended.
How does this work?
In Azure AI Studio we can setup content filters and attach them to specific deployments.
Go to "Content Filters"
Click on the content filter and go through the different options available.