# abwabstudio.com

The public website for AlSaahib (الصَّاحِب), an iPhone app for memorizing the Quran, made by Abwab Studio.
Plain HTML and one stylesheet, served by GitHub Pages at https://abwabstudio.com.

**Everything in this repository is public.** Do not add source code, keys, internal plans, test data or personal
details. Contact on the site is email only: support@abwabstudio.com.

No JavaScript, no analytics, no cookies, and no requests to any other site: the fonts, icons and screenshots are
all served from this repository. The only links to other sites are ordinary links (licenses, sources, other
companies' privacy policies) and `mailto:` links.

## What is here

| File | Served at | What it is |
|---|---|---|
| `index.html` | `/` | The landing page: what the app is, how to join the test, teacher calls, your information |
| `privacy.html` | `/privacy` | Privacy policy for the free TestFlight test |
| `terms.html` | `/terms` | Terms for the free test |
| `support.html` | `/support` | How to get help, deleting an account, common questions |
| `credits.html` | `/credits` | Sources and licenses: Quran text, recitation, translations, fonts, software |
| `404.html` | any missing page | "Page not found" (uses root-relative links so it works at any path) |
| `style.css` | | The one stylesheet: light and dark (follows the device setting), phone to desktop |
| `assets/screens/` | | Five app screenshots, 780 px wide JPEG |
| `assets/fonts/` | | Inter, Space Grotesk and Amiri, cut down to the letters the site uses (WOFF2), with their licenses |
| `assets/icons/`, `favicon.ico` | | App icon at 48, 180 (Apple touch icon) and 192 px |
| `assets/og-image.jpg` | | 1200 × 630 preview image for links shared in messages and social apps |
| `robots.txt`, `sitemap.xml` | | Allow search engines; list the five pages |
| `CNAME` | | The custom domain, read by GitHub Pages |
| `.github/workflows/pages.yml` | | Publishes the site on every push to `main` |
| `tools/` | not served | Scripts to refresh the screenshots and rebuild the fonts |
| `README.md` | not served | This file |

## Preview on your computer

```sh
python3 -m http.server 8000
```

Then open http://localhost:8000. Check each page at phone width (the browser's responsive mode, 375 px) and in dark
mode.

## Publish

Pushing to `main` runs `.github/workflows/pages.yml`, which uploads only the served files (the pages, `style.css`,
`assets/`, `CNAME`, `favicon.ico`, `robots.txt` and `sitemap.xml`) to GitHub Pages. It can also be run by hand from
the Actions tab.

## Where to paste the TestFlight link

There is one place, in `index.html`: the line with `id="join-link"`. When a public TestFlight link exists, change
its `href` to that link and its label to "Join the free test", and change the sentence below it (`id="join-note"`)
and the "How to join the test" steps. Then update `support.html` → "How do I get the app?", which says the test is
by invitation.

## Refresh the screenshots

```sh
tools/refresh-screens.sh /path/to/the/app/screenshot/gallery
```

It needs ImageMagick. It copies `home`, `reader-memorize`, `reader-hidden`, `notes-page` and `call-teacher`,
resizes them to 780 px wide, trims the bottom of four of them (see the script) and saves them as JPEG. If a screen
changes, update its `alt` text and its `width`/`height` attributes in `index.html`.

## Fonts

The site uses subsets of the fonts (WOFF2). Rebuild them with `tools/build-fonts.sh` (needs
`pip install fonttools brotli`).

## Rules for this folder

- No JavaScript, analytics, tracking pixels, or files from other sites.
- No images of living beings.
- Plain language and American spelling. Arabic text is marked `lang="ar" dir="rtl"`.
- Keep the pages true: when the app changes what it collects, change `privacy.html` and its date before the build
  reaches testers.
- Nothing confidential: anyone can read this repository and view the source of every page.
