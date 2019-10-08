$tagName = "hjerpbakk/github-actions-demo"
$dockerfile = "Dockerfile.windows"
docker build -t $tagName -f $dockerfile .
