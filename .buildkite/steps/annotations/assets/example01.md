<p class="h1 pb1">👋 Welcome to Buildkite Annotations</p>

<p>Let's take a look at some of the things you can do with annotations...</p>

---

<p class="">
  <span class="regular">We can use </span>
  <span class="bold black">black</span>
  <span class="bold gray">gray</span>
  <span class="bold blue">blue</span>
  <span class="bold green">green</span>
  <span class="bold orange">orange</span>
  <span class="regular">or</span>
  <span class="bold red">red</span>
  <span class="regular">font colors</span>
</p>

<p class="">
  <span class="h6">We can </span>
  <span class="h5">use one</span>
  <span class="h4">of many</span>
  <span class="h3">different</span>
  <span class="h2">font</span>
  <span class="h1">sizes</span>
</p>

<p class="">
  <span class="regular">We can use </span>
  <span class="bold">bold</span>
  <span class="italic">italic</span>
  <span><sub>subscript</sub></span>
  <span><sup>superscript</sup></span>
  <span class="underline">underline</span>
  <span class="caps">or all caps</span>
</p>

---

We can use `inline code` to show code inside a paragraph

Or a basic code block

```
function logSomething(something) {
  console.log("Something", something);
}
```

Or a fancy terminal code block

```term
\x1b[31mFailure/Error:\x1b[0m \x1b[32mexpect\x1b[0m(new_item.created_at).to eql(now)

\x1b[31m  expected: 2018-06-20 19:42:26.290538462 +0000\x1b[0m
\x1b[31m       got: 2018-06-20 19:42:26.290538000 +0000\x1b[0m

\x1b[31m  (compared using eql?)\x1b[0m
```

---

Blockquotes and flexbox

<div class="flex">
  <div class="flex-auto border rounded p2">
    <blockquote class="my1 py1 h6 bold">We can use blockquotes</blockquote>
    <blockquote class="my1 py1 h5 regular italic">In different styles</blockquote>
    <blockquote class="h4 mt1 mb0 pb0">Or make them nested<blockquote class="h4 mb0 pb0">Deeper<blockquote class="h4 mb0">And deeper</blockquote></blockquote></blockquote>
  </div>
  <div class="flex-auto border rounded p2">
    <blockquote class="mb0 mt1 py1 h3">Or make them bigger</blockquote>
    <blockquote class="mb0 mt1 py1 h2">And bigger</blockquote>
    <blockquote class="mb0 mt1 py1 h1">And bigger</blockquote>
  </div>
</div>

---

We can use tables

<div class="flex h6 regular overflow-scroll">
  <div class="flex-none">
    <table class="border rounded">
      <thead class="bold">
        <tr>
          <th>Artist</th> <th>Album</th> <th>Release Date</th>
        </tr>
      </thead>
      <tbody>
        <tr> <td>Huey Lewis and the News</td> <td>Sports</td> <td>1983</td> </tr>
        <tr> <td>Phil Collins</td> <td>No Jacket Required</td> <td>1985</td> </tr>
        <tr> <td>Peter Gabriel</td> <td>So</td> <td>1986</td> </tr>
      </tbody>
    </table>
  </div>
</div>

<div class="flex h6 regular overflow-auto">
  <table class="">
    <thead>
      <tr>
        <th>Artist</th> <th>Album</th> <th>Release Date</th>
      </tr>
    </thead>
    <tbody>
      <tr> <td>Huey Lewis and the News</td> <td>Sports</td> <td>1983</td> </tr>
      <tr> <td>Phil Collins</td> <td>No Jacket Required</td> <td>1985</td> </tr>
      <tr> <td>Peter Gabriel</td> <td>So</td> <td>1986</td> </tr>
    </tbody>
  </table>
</div>

---

We can display, resize, and round images

<div class="">
  <img class="rounded" src="artifact://assets/man.gif" alt="man-nodding" title="this will be displayed as a tooltip" width="174" />
  <img class="" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" title="this will be displayed as a tooltip" width="128" height="128" />
  <img class="rounded" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" title="this will be displayed as a tooltip" width="128" height="128" />
  <img class="rounded" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" title="this will be displayed as a tooltip" width="64" height="64" />
  <img class="rounded" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" title="this will be displayed as a tooltip" width="32" height="32" />
</div>
---

Sections can be expanded and collapsed

<details class="pt1">
  <summary class="h4"><span class="pl1">Expand this section to see font-size options...</span></summary>
  <div class="pl3">
    <p class="h1">Heading 1</p>
    <p class="h2">Heading 2</p>
    <p class="h3">Heading 3</p>
    <p class="h4">Heading 4</p>
    <p class="h5">Heading 5</p>
    <p class="h6">Heading 6</p>
  </div>
</details>

<details class="pt1">
  <summary class="h4"><span class="pl1">Expand this section to see typography options...</span></summary>
  <div class="pl3 mb1">
    <p class="h5 mb1 regular">Regular text</p>
    <p class="h5 mb1 bold">Bold text</p>
    <p class="h5 mb1 italic">Italic text</p>
    <p class="h5 mb1 underline">Underline text</p>
    <p class="h5 mb1 caps">All caps text</p>
    <p class="h5 mb0 left-align rounded">Left align text</p>
    <p class="h5 mb0 center rounded">Center text</p>
    <p class="h5 mb2 right-align rounded">Right align text</p>
    <p class=""><span class="bold">This is a normal paragraph </span>bacon ipsum dolor sit amet chuck prosciutto landjaeger ham hock filet mignon shoulder hamburger pig venison.</p>
    <p class="justify"><span class="bold">This Paragraph of text will be justified, resize the browser window to see it in action! </span>bacon ipsum dolor sit amet chuck prosciutto landjaeger ham hock filet mignon shoulder hamburger pig venison.</p>
    <p class="truncate"><span class="bold">This Paragraph of text will be truncated, resize the browser window to see it in action! </span>bacon ipsum dolor sit amet chuck prosciutto landjaeger ham hock filet mignon shoulder hamburger pig venison.</p>
  </div>
</details>

<details class="pt1">
  <summary class="h4"><span class="pl1">Expand this section to see table options...</span></summary>
  <div class="pl3">

  <p class="h4">h6 table</p>

  <div class="h6 regular overflow-scroll">
    <table class="table-light">
      <thead>
        <tr>
          <th class="px1 py2">Artist</th> <th>Album</th> <th>Release Date</th>
        </tr>
      </thead>
      <tbody class="mxn2 px1">
        <tr class="mxn2 px1"> <td>Huey Lewis and the News</td> <td>Sports</td> <td>1983</td> </tr>
        <tr> <td class="mxn2 px1">Phil Collins</td> <td>No Jacket Required</td> <td>1985</td> </tr>
        <tr> <td>Peter Gabriel</td> <td class="mxn2">So</td> <td>1986</td> </tr>
      </tbody>
    </table>
  </div>

  <p class="h4">h6 table with underline header and rounded border</p>

  <div class="flex h6 overflow-scroll">
    <div class="flex-none">
      <table class="border rounded">
        <thead class="bold underline">
          <tr>
            <th>Artist</th> <th>Album</th> <th>Release Date</th>
          </tr>
        </thead>
        <tbody class="regular">
          <tr> <td>Huey Lewis and the News</td> <td>Sports</td> <td>1983</td> </tr>
          <tr> <td>Phil Collins</td> <td>No Jacket Required</td> <td>1985</td> </tr>
          <tr> <td>Peter Gabriel</td> <td>So</td> <td>1986</td> </tr>
        </tbody>
      </table>
    </div>
  </div>

  </div>
</details>

<details class="pt1">
  <summary class="h4"><span class="pl1">Expand this section to see image options...</span></summary>
  <div class="pl3 mb1">
    <img class="" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" width="128" height="128" />
    <img class="rounded" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" width="128" height="128" />
    <img class="rounded" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" width="64" height="64" />
    <img class="rounded" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" width="32" height="32" />
    <img class="rounded" src="artifact://assets/man.gif" alt="man-nodding" width="164" />
  </div>
</details>
