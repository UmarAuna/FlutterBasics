## What is a widget

A **widget** is a building block for your user interface. Using widgets is like combining  Legos. Like Legos, you can mix and match widgets to create something amazing.

## **Types of elements**

There are two types of elements:

1. **ComponentElement**: A type of element that’s composed of other elements. This 

   corresponds to composing widgets inside other widgets.

2. **RenderObjectElement**: A type of element that holds a render object.

You can think of **ComponentElement** as a group of elements, and 

**RenderObjectElement** as a single element. Remember that each element contains a 

render object to perform widget painting, layout and hit testing.



## **Types of widgets**

There are two major types of widgets: **stateless** and **stateful** widgets. You’ll take a 

closer look at the differences between them next.

#### **Stateless widgets**

Stateless Widgets are immutable. You can’t alter the state or properties of this  widget once built. When your properties don’t need to change over time, it’s  generally a good idea to start with a stateless widget.  The lifecycle of a stateless widget starts with a constructor, which you can pass  parameters to, and a build() method, which you override. The visual description of the widget is determined by the build() method.

![](/home/umar-auna/StudioProjects/flutter_basics_2/lib/Chapter-4/Screenshot from 2021-10-13 11-10-39.png)

The following events trigger this kind of widget to update:

1. The widget is inserted into the widget tree.

2. The state of a dependency or inherited widget — ancestor nodes — changes.

#### **Stateful widgets**

Stateful widgets preserve state, which is useful when parts of your UI need to change  dynamically. For example, one good time to use a stateful widget is when a user taps a **Favorite** button to toggle a simple Boolean value on and off.

Stateful widgets store their mutable state in a separate State class. That’s why every  stateful widget must override and implement createState().

![](/home/umar-auna/StudioProjects/flutter_basics_2/lib/Chapter-4/Screenshot from 2021-10-13 11-09-29.png)

![](/home/umar-auna/StudioProjects/flutter_basics_2/lib/Chapter-4/state_life_cycle.png)