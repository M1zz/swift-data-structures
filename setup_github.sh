#!/bin/bash
# =============================================================
# Swift 자료구조 — GitHub + GitHub Pages 셋업 스크립트
# 사용법: bash setup_github.sh
# 필요: git, gh (GitHub CLI) 설치 필요
# =============================================================

set -e

REPO_NAME="swift-data-structures"
REPO_DESC="Swift로 배우는 자료구조 — 인터랙티브 시각화 + Playground Book | 개발자리"

echo ""
echo "🚀 Swift 자료구조 GitHub 셋업 시작"
echo "======================================"

# 1. gh 설치 확인
if ! command -v gh &> /dev/null; then
  echo ""
  echo "❌ GitHub CLI(gh)가 설치되어 있지 않습니다."
  echo "   설치: brew install gh"
  echo "   설치 후 다시 실행하세요."
  exit 1
fi

# 2. gh 로그인 확인
if ! gh auth status &> /dev/null; then
  echo ""
  echo "🔐 GitHub 로그인 필요:"
  gh auth login
fi

# 3. git 초기화
echo ""
echo "📁 git 초기화..."
git init
git add .
git commit -m "feat: Swift 자료구조 교안 초기 커밋

- index.html: 10개 챕터 인터랙티브 시각화
- DataStructures.playgroundbook: Swift Playgrounds 실습북
- Swift_자료구조_교안.docx: 학습 교안"

# 4. GitHub repo 생성 + push
echo ""
echo "☁️  GitHub repo 생성: $REPO_NAME"
gh repo create "$REPO_NAME" \
  --public \
  --description "$REPO_DESC" \
  --source=. \
  --remote=origin \
  --push

# 5. GitHub Pages 활성화 (main 브랜치 루트)
echo ""
echo "🌐 GitHub Pages 활성화..."
gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  "/repos/$(gh api user --jq .login)/$REPO_NAME/pages" \
  -f "source[branch]=main" \
  -f "source[path]=/" \
  2>/dev/null || \
gh api \
  --method PUT \
  -H "Accept: application/vnd.github+json" \
  "/repos/$(gh api user --jq .login)/$REPO_NAME/pages" \
  -f "source[branch]=main" \
  -f "source[path]=/" \
  2>/dev/null || true

# 6. 결과 출력
GITHUB_USER=$(gh api user --jq .login)
echo ""
echo "======================================"
echo "✅ 완료!"
echo ""
echo "📦 Repository:"
echo "   https://github.com/$GITHUB_USER/$REPO_NAME"
echo ""
echo "🌐 GitHub Pages (배포까지 1~2분 소요):"
echo "   https://$GITHUB_USER.github.io/$REPO_NAME/"
echo ""
echo "💡 Pages가 안 보이면:"
echo "   Settings → Pages → Branch: main / (root) → Save"
echo "======================================"
