# The foundation of generative AI in Azure

This repo hosts the material for the Microsoft AI Tour session *The foundation of generative AI in Azure*.

## Session Desciption

Discover the basics of generative AI, including core models, functionalities. Learn how to utilize these models within the Azure ecosystem, leveraging various services to build your own generative AI applications.

## Learning Outcomes

* Learn about the history of AI at Microsoft
* Explore the Azure AI services
* Understand how language models work
* Learn how to interact with large language models
* Explore various types of models for different usecases

## Technology Used

* Azure AI Studio *(Chat playground with GPT-4o and GPT-4o mini, Content filters, Assistants)*
* Azure Speech service *(Text to Speech Avatar, Live Chat Avatar, Video Translation)*
* GitHub playground for AI models *(OpenAI GPT-4o mini, Mistral Large)*
* GitHub Codespaces

## Additional Resources and Continued Learning

| Resources          | Links                             | Description        |
|:-------------------|:----------------------------------|:-------------------|
Microsoft Azure AI Fundamentals: AI Overview | [Microsoft Learn path](https://learn.microsoft.com/en-us/training/paths/get-started-with-artificial-intelligence-on-azure/) | Learn how Artificial Intelligence (AI) empowers amazing new solutions and experiences; and explore Microsoft Azure that provides easy to use services to help you get started.  
| Microsoft Azure AI Fundamentals: Generative AI | [Microsoft Learn path](https://learn.microsoft.com/en-us/training/paths/introduction-generative-ai/) | Learn how Azure AI Studio leverages language models and responsible AI principles to provide cutting-edge generative AI technology, including copilots that enhance efficiency through ethical AI-driven prompts and responses. |
| Get started with Azure AI Services | [Microsoft Learn path](https://learn.microsoft.com/en-us/training/paths/get-started-azure-ai/) | earn how to provision, secure, monitor, and deploy Azure AI Services resources and use them to build intelligent solutions. |

## Content Owners

<table>
<tr>
    <td align="center"><a href="http://learnanalytics.microsoft.com">
        <img src="https://github.com/hnky.png" width="100px;" alt="Chris Testa-O'Neill
"/><br />
        <sub><b>Henk Boelman
</b></sub></a><br />
            <a href="https://github.com/hnky" title="talk">📢</a> 
    </td>
        <td align="center"><a href="http://learnanalytics.microsoft.com">
        <img src="https://github.com/aycabas.png" width="100px"    alt="Ayca Bas"/><br />
        <sub><b>Ayca Bas</b></sub></a>
        <br />
        <a href="https://github.com/aycabas" title="talk">📢</a> 
    </td>
</tr></table>

## Responsible AI

Microsoft is committed to helping our customers use our AI products responsibly, sharing our learnings, and building trust-based partnerships through tools like Transparency Notes and Impact Assessments. Many of these resources can be found at [https://aka.ms/RAI](https://aka.ms/RAI).
Microsoft’s approach to responsible AI is grounded in our AI principles of fairness, reliability and safety, privacy and security, inclusiveness, transparency, and accountability.

Large-scale natural language, image, and speech models - like the ones used in this sample - can potentially behave in ways that are unfair, unreliable, or offensive, in turn causing harms. Please consult the [Azure OpenAI service Transparency note](https://learn.microsoft.com/legal/cognitive-services/openai/transparency-note?tabs=text) to be informed about risks and limitations.

The recommended approach to mitigating these risks is to include a safety system in your architecture that can detect and prevent harmful behavior. [Azure AI Content Safety](https://learn.microsoft.com/azure/ai-services/content-safety/overview) provides an independent layer of protection, able to detect harmful user-generated and AI-generated content in applications and services. Azure AI Content Safety includes text and image APIs that allow you to detect material that is harmful. Within Azure AI Studio, the Content Safety service allows you to view, explore and try out sample code for detecting harmful content across different modalities. The following [quickstart documentation](https://learn.microsoft.com/azure/ai-services/content-safety/quickstart-text?tabs=visual-studio%2Clinux&pivots=programming-language-rest) guides you through making requests to the service.

Another aspect to take into account is the overall application performance. With multi-modal and multi-models applications, we consider performance to mean that the system performs as you and your users expect, including not generating harmful outputs. It's important to assess the performance of your overall application using [Performance and Quality and Risk and Safety evaluators](https://learn.microsoft.com/azure/ai-studio/concepts/evaluation-metrics-built-in). You also have the ability to create and evaluate with [custom evaluators](https://learn.microsoft.com/azure/ai-studio/how-to/develop/evaluate-sdk#custom-evaluators).

You can evaluate your AI application in your development environment using the [Azure AI Evaluation SDK](https://microsoft.github.io/promptflow/index.html). Given either a test dataset or a target, your generative AI application generations are quantitatively measured with built-in evaluators or custom evaluators of your choice. To get started with the azure ai evaluation sdk to evaluate your system, you can follow the [quickstart guide](https://learn.microsoft.com/azure/ai-studio/how-to/develop/flow-evaluate-sdk). Once you execute an evaluation run, you can [visualize the results in Azure AI Studio](https://learn.microsoft.com/azure/ai-studio/how-to/evaluate-flow-results).

