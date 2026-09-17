# TIFOR — AI Animation for Retail

Course website for **AI Animation for Retail: Product Videos & Social Ads**, delivered under
Tembusu Institute's registered course *The Future of Retail* (TGS-2022016568).

Live site: **https://ac-eduworks.com/tifor/** (served from the `tifor/` folder of the `ac-eduworks-root` repo, which owns the ac-eduworks.com domain on GitHub Pages).
Staging copy: https://ancch17.github.io/TIFOR/ (this repo's own Pages build).

## Stack
Single static page — `index.html` with inline CSS/JS, self-hosted fonts and images in `assets/`.
No build step. Deployed with GitHub Pages from the `main` branch root.

## Deploying to ac-eduworks.com/tifor
This repo is the source of truth. After committing here, run `.\deploy.ps1` (Windows PowerShell, needs `git` + a signed-in `gh`):
it clones/pulls `ancch17/ac-eduworks-root`, copies only `index.html` and `assets/` into its `tifor/` folder, commits and pushes. GitHub Pages rebuilds in about a minute.

## Editing
- Copy, sections and styles: `index.html`
- Registration link: search for `tembusuinstitute.edu.sg/courses` (appears in the nav, hero, funding section and final CTA)
- Showcase videos: the three YouTube IDs live on the `.play` buttons (`data-video`) and the "Open on YouTube" links
- Storyboard frames: `assets/story-1.webp` … `story-6.webp`
- Hero background loop: `assets/hero-bg.mp4` (720×1280, muted) with `assets/hero-bg.jpg` as poster

## Credits
Sample videos and stills © AndrewLearnsAI. Tembusu Institute logo © Tembusu Institute.
Google Flow, Suno and CapCut are trademarks of their respective owners.
