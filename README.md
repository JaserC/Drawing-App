# Drawing App

## Student Information

Name: Jaser Chowdhury

UW netid: jaserc

CSE netid (if any): jaserc

email: jaserc@uw.edu

## Resources Used

Cite anything (website or other resource) or anyone that assisted you in creating your solution to this assignment.

Remember to include all online resources (other than information learned in lecture or section and android documentation) such as Stack Overflow, other blogs, students in this class, or TAs and instructors who helped you during Office Hours. If you did not use any such resources, please state so explicitly.

Answer here: 

https://pub.dev/packages/gradient_borders/install 
https://www.kodeco.com/25237210-building-a-drawing-app-in-flutter
https://medium.com/@nerapa21/what-is-covariant-86fe563c6248
Lot of Flutter documentation
Lecture Slides
Huakun Xu

## Reflection Prompts

### New Learnings

What new tools, techniques, or other skills did you learn while doing this assignment?

How do you think you might use what you learned in the future?

Were the examples and explanations from lecture helpful? How could they be improved in the future to assist with this assignment?

Answer here: First off, we learned about using covariants, which was pretty cool. Covariants are used to relax the type constraints on the parameters of an overriding subclass. For this particualr method, making it covariant allowed a very specific cast stating tht we are strictly looking for DrawingPainters as the CustomPainter argument to this function. This method uses this parameter to compare a drawing with the current one, so you must specifically type cast it down for them to be comparable. The override is also valid because it is a specific/narrowing cast. 

As for some of the other stuff we learned, I thought the entirely lesson on canvas and painting was pretty cool. It opens up the door for us to build our own custom widgets that get drawn onto the screen. I came across a few code snippets that did that prior and now I have a baseline understanding of what they are essentially doing. It really opens up the doors in terms of future design possibilities. I also, as usual, got to experiment with different flutter libraries and packages to see and test different functionalities out. I installed a gradient border package for this one that I ultimately only used on 1 color button, but it was a creative decision. 

I personally didn't use the lecture slides much. I don't think they had much bearing outside of going over some basic points. The pre-filled out code was much more intuitive to understand and gave me a better idea of what I should be doing and how. And if all else goes to fail, VS Code as an IDE gives you a lot of help when it comes to understanding different flutter elements - You just have to hover your cursor over something to get a brief description.  

## Challenges

What was hard about doing this assignment?
What did you learn from working through those challenges?

Answer here: This assignment wasn't super hard. I thought some of the harder parts were about figuring out the right way of implementing something. When it comes to the specs, things are left pretty open-ended, so you don't really know if you are doing the right thing or if you're just shooting blindly. My OvalAction was weird for a while because I didn't know what fields I wanted to use along with what constructor to finally draw the oval. It led to me writing and deleting a couple implementations. With this, I learned that I should probably mock the data before working on the rest of the app because it can be a big roadblock.

### Mistakes

What is one mistake that you made or misunderstanding that you had while you were completing this assignment?

What is something that you learned or will change in the future as a result of this mistake or misunderstanding?

Answer here: After implementing my Stroke Action, I realized that my brush strokes were weird in that points were spaced out. It looked like a collection of points rather than something continuous. The reason for this was that I didn't read the instructions and see the draw a line between points suggestion. After I did that, the brush stroke became much more seamless. Prior to that, I was iterating through the offset list and just drawing each point individually. With very fast strokes, the gaps becomes very noticeable if you don't find a way to connect them. So, going forward I'm gonna look through the entire spec first before coding. 

### Meta

How much time (in minutes or hours of active work) did you spend working on this assignment?

8 hrs.

What parts took the longest?

The pallette definitiely took the longest time because I was wishhy washy with my design. I didn't commit to something before starting and then it just became a bunch of coding, deleting, and coding again. I also didn't know how to make my containers for a long time right until when I'm submitting this. I guess the last fiew assignment have removed me completely from using the Container widget so there's that. Otherwise, I thought a lot of the backend stuff was a couple of lines and easy to conceptually grasp. 

What could we do to make this assignment better in the future?

I would've appreciated some of the instructions being a bit more clear. There were times when the details were left somewhat vague as to how to implement something, and that was a bit confusing. Now, that may have been by design for us to just figure out, but with Flutter there's lot of diferent ways to do things and leaving things open-ended could leave you going down the rabbit hole. I, personally, had to change my OvalAction 3 times because I didn't like how it ended up drawing and I'm still not certain I do. A hint here would've been appreciated. 
