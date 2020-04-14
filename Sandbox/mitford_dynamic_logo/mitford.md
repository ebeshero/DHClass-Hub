# Mitford Logo Explanation

The logo is in a flexbox (div class="mitford") in this html page, making it easy to move on a page.

## CSS
  * **Problems**
    * Flexboxes do not overlap eachother
      * Images for the hover effect
      * Links cannot overlap image
    * GIFs cache

```
<div class="mitford">
  <div class="top">
    <a href="https://digitalmitford.org/letters.html"> </a>
    <a href="https://digitalmitford.org/"> </a>
  </div>
  <div class="bottom">
    <a href="https://digitalmitford.org/visual.html"> </a>
    <a href="https://digitalmitford.org/bibliogType.html"> </a>
  </div>
</div>
```

  * **Solutions**
  
    **Background-image**
    ```
    .mitford{
    display: flex;
    flex-direction: column;
    height: 200px;
    width: 160px;
    background-repeat: no-repeat;
    background-image: url(mitford_start.png);
    background-size: auto 200px;
    }
    .mitford:hover{
        background-image: url(mitford.gif);
        background-size: auto 200px;
    }
    ```
    By using the background-image css property, the image is not located within the actual flexbox.
    This also solves the links problem because now we are working with an empty flexbox!
    
    **Links**
    ```
    .top, .bottom{
    display: flex;
    flex-direction: row;
    width: 100%;
    height: 50%;
    }
    .top a, .bottom a{
        width: 50%;
        height: 100%;
    }
    .top{order: 1}
    .bottom{order: 2}
    ```
    With the flexbox container empty of an image, we can now nest containers inside to contain our links.
    
    The first two containers, top and bottom, are used to separate the top right and top left links from the bottom right and bottom left links. We state that the width of each container is 100% and that the height is 50%. This cuts the flexbox in half horizontally.
    
    We can then put two links in the top and bottom links. This time, we say that the height of each anchor element is 100% of the parent container and 50% width, dividing the flexbox in half vertically.

    **GIFs**
    * Infinite loop VS. one loop
    
    A GIF that is set to loop only once on a webpage will cache. This means that once the GIF loops, it won't restart unless the browser window is refreshed. We can negate this by creating a javascript, but it's a little complicated since we used the backround-image css porperty. Instead, I extended the final frame length in which the puzzle pieces remain together and set it as infinite loop.
    
    
