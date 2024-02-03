# Wikimedia Commons POTD

Download [Wikimedia Commons pictures of the day](https://commons.wikimedia.org/wiki/Category:Pictures_of_the_day) from 2004 to present year and optimize them for use as wallpaper by downscaling and converting to AVIF to drastically reduce size.

## Caveats

Depends on [nytpu/commons-downloader](https://git.sr.ht/~nytpu/commons-downloader).

It is inefficient and will download thousands of images sources from Commons at the highest quality taking considerable time and disk space — ~55GB where final size is ~2.5GB. Instead of skipping undesirables like GIFs and low resolution pictures when extracting it will remove them later after download. I didn't bother to write a proper program because I intended to use it only once and if you're just interested in the pictures it's easier to just clone the repo.

## Usage

```sh
cd commons-potd
./extract.sh
./transform.sh
```

## Copyright

Code is licensed with [MIT](https://mit-license.org/).

```
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

Images retain their original licenses which should be evaluated case by case. Omit the `.avif` and lookup copyright info at: `https://commons.wikimedia.org/wiki/File:<FILE_NAME>`.
