# Demo 10 - Content Safety

**Description**
TBA

**Goal**
TBA

## Demo: Holiday Home

### Prompt:
Create a tagline and short description for this rental home advertisement.
- The first picture is from the home
- The other pictures are from sights nearby
- In the description use the features of the house and make the ad more compelling with the sights. 
- Do not talk about features not visible in the images.
- If you have information about the location of the images, use that information in the description
   
## Demo: Context is everything
For this next demo, we have an obstructed image. I purposefully put the bounding boxes there to make it not clear so you don't have the full context. 
This is my example where context is everything. And GPT-4o is the first large-scale model that actually bakes context in. 
   
Upload: image1.  
prompt: What is that?    
  
If I asked anyone in this room, "Hey, what is this?" Everyone would probably really struggle to come up with what that text is. 
This is the classic computer vision problem with optical character recognition. Is if you were looking at that word in isolation, what is the actual word?
   
If I ask GPT-4o with Vision, "What is that?" It says, "The text is not clearly readable due to the handwritten nature. It could be a signature like 'Mark’.” 
The other interesting thing is it actually knows, hey, "There appears to be portions of the text that are blocked out and cannot be read.
   
Upload: image2   
Prompt: Extract all the texts from the image. Explain what you think this is.   
  
If I reveal a little bit more, I have one person who's been able to figure out what this was at this point, but it's still pretty challenging to say what is this.  In this case, I changed the prompt a little bit. Extract all the texts from the image. Explain what you think this is.
And GPT-4 Turbo with Vision responded back with this, it said, "This is milk, steak" and it appears to be a shopping list. It basically makes the note that the image is still obscured, which is interesting. 
   
Upload: image3.  
Prompt: Extract all the texts from the image. Explain what you think this is.   

We can see,  GPT-4 Turbo with Vision is actually correct, and it is indeed a shopping list when I reveal the whole thing.
it's able to perfectly translate what I'm trying to say there, "mayo, organic bread" Even more interesting is the note at the bottom. It actually gets the subtleties of what's going on. It says, where is it? 
"The note on the beer item suggests a reminder or emphasis on moderation or limiting the purchase quantity."