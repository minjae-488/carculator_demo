# Tech Spec: 공학용 전자계산기 웹 애플리케이션 (Carculator)

## 1. 개요 (Overview)

본 문서는 **Carculator** 프로젝트의 기술적 구현 상세를 정의합니다. 이 프로젝트는 모바일 우선(Mobile-First) 디자인을 따르는 웹 기반의 공학용 전자계산기입니다. 높은 성능과 정확한 계산, 그리고 미려한 UI/UX를 제공하기 위해 최신 웹 기술 표준을 준수합니다.

---

## 2. 아키텍처 (Architecture)

### 2.1 시스템 구조
- **Client-Side Rendering (CSR)**: 모든 로직은 사용자의 브라우저에서 실행됩니다.
- **Single Page Application (SPA)**: 페이지 새로고침 없는 부드러운 사용자 경험을 제공합니다.
- **PWA (Progressive Web App)** (선택 사항): 추후 모바일 앱처럼 설치하여 사용할 수 있도록 고려합니다.

### 2.2 디렉토리 구조 (제안)
```
/
├── public/
│   └── icons/          # 정적 에셋
├── src/
│   ├── components/     # UI 컴포넌트 (렌더링 로직)
│   │   ├── Display.js
│   │   ├── Keypad.js
│   │   └── ThemeToggle.js
│   ├── core/           # 비즈니스 로직 (순수 함수)
│   │   ├── Calculator.js
│   │   ├── MathOperations.js
│   │   └── HistoryManager.js
│   ├── styles/
│   │   └── main.css    # Tailwind 지시어 포함
│   ├── utils/          # 유틸리티 함수
│   │   ├── storage.js
│   │   └── formatter.js
│   └── main.js         # 엔트리 포인트
├── index.html
├── package.json
├── tailwind.config.js
└── vite.config.js
```

---

## 3. 기술 스택 (Technology Stack)

### 3.1 프론트엔드 (Frontend)

| 카테고리 | 기술 | 선택 이유 |
|----------|------|-----------|
| **Core** | **JavaScript (ES6+)** | 별도의 무거운 프레임워크 없이 바닐라 JS로 가볍고 빠른 성능 구현 |
| **Markup** | **HTML5** | 시멘틱 태그 활용 (접근성 준수) |
| **Styling** | **Tailwind CSS** | 유틸리티 퍼스트 접근법으로 빠른 UI 개발 및 일관된 디자인 시스템 적용 |
| **Icons** | **Material Symbols** | Google의 최신 아이콘 시스템, 가독성 및 디자인 일관성 확보 |
| **Fonts** | **Space Grotesk** | 공학적이고 현대적인 느낌을 주는 가독성 높은 산세리프 폰트 |

### 3.2 빌드 및 개발 환경 (Build & Dev Tools)

| 카테고리 | 기술 | 선택 이유 |
|----------|------|-----------|
| **Bundler** | **Vite** | 빠른 HMR(Hot Module Replacement) 지원 및 최적화된 빌드 성능 |
| **Package Manager** | **npm** | 표준 노드 패키지 매니저 |
| **Linting** | **ESLint** | 코드 품질 유지 및 잠재적 오류 방지 |
| **Formatting** | **Prettier** | 일관된 코드 스타일 유지 |

### 3.3 핵심 라이브러리 (Libraries)

| 라이브러리 | 용도 | 비고 |
|------------|------|------|
| **decimal.js** (또는 big.js) | **정밀 계산** | JavaScript의 부동소수점 오류(예: 0.1 + 0.2 != 0.3) 해결을 위해 필수 |
| **dayjs** (선택) | 날짜 처리 | 히스토리 기록의 타임스탬프 처리 시 필요할 경우 사용 |

---

## 4. 데이터 모델 및 상태 관리 (Data Model & State Management)

### 4.1 상태 (State) 구조
애플리케이션의 상태는 하나의 중앙 객체(Store) 또는 클래스 인스턴스에서 관리하며, 다음과 같은 구조를 가집니다.

```javascript
const appState = {
  currentValue: "0",       // 현재 입력값 (문자열)
  previousValue: null,     // 이전 값 (연산 대기 중)
  operator: null,          // 선택된 연산자
  isScientific: false,     // 공학 모드 여부
  history: [],             // 계산 기록 배열
  theme: "system",         // 'light' | 'dark' | 'system'
  dirty: false             // 입력 진행 중 여부 (AC vs C 버튼 전환용)
};
```

### 4.2 데이터 흐름 (Data Flow)
1. **User Action**: 버튼 클릭 이벤트 발생
2. **Event Handler**: 입력값 검증 및 처리
3. **Core Logic**: `Calculator.js`에서 연산 수행 (`decimal.js` 활용)
4. **State Update**: 결과값 상태 업데이트
5. **UI Update**: 변경된 상태를 감지하여 DOM 업데이트 (Observer 패턴 또는 직접 렌더링 호출)

### 4.3 영구 저장 (Persistence)
브라우저의 `localStorage`를 사용하여 다음 데이터를 유지합니다.
- `calculator_theme`: 테마 설정
- `calculator_history`: 최근 50개 계산 기록 (JSON 직렬화)

---

## 5. 핵심 로직 구현 상세 (Implementation Details)

### 5.1 부동소수점 처리
JavaScript의 `Number` 타입을 직접 사용하지 않고, 수학 라이브러리를 래핑하여 연산합니다.

```javascript
// 예시: 덧셈 구현
import Decimal from 'decimal.js';

function add(a, b) {
  return new Decimal(a).plus(b).toString();
}
```

### 5.2 수식 파싱 (Advanced)
공학용 계산기의 괄호 및 우선순위 연산을 위해 **Shunting-yard 알고리즘** 또는 **재귀 하향 파서(Recursive Descent Parser)** 구현을 고려합니다.
*MVP 단계에서는 즉시 실행 방식(누구 값이 입력되면 바로 연산)을 채택하되, 추후 수식 입력 방식을 위한 확장성을 열어둡니다.*

### 5.3 테마 시스템
Tailwind의 `darkMode: 'class'` 전략을 사용합니다.
- `html` 태그에 `dark` 클래스 토글
- CSS 변수를 활용하여 의미론적 색상 정의 (예: `--color-bg-primary`)

---

## 6. 테스트 전략 (Testing Strategy)

### 6.1 단위 테스트 (Unit Testing)
- **TDD 적용 대상**: **코어 비즈니스 로직 전용** (`MathOperations.js`, `Calculator.js`, `HistoryManager.js`)
- **도구**: Vitest
- **방식**: Red-Green-Refactor 사이클 준수
- **케이스**:
  - 일반 연산 정합성 검증
  - 부동소수점 오류 케이스 (0.1 + 0.2)
  - 0으로 나누기, 오버플로우 등 예외 처리

### 6.2 UI 테스트 (UI Testing)
- **자동화 금지**: UI 컴포넌트 및 DOM 상호작용에 대한 자동화 테스트는 작성하지 않습니다.
- **수동 테스트 (Manual QA)**:
  - 브라우저(Chrome, Safari 등)에서 직접 UI 동작 확인
  - 모바일 반응형 레이아웃 확인
  - 키보드 및 마우스 인터랙션 확인

---

## 7. 보안 및 성능 (Security & Performance)

### 7.1 보안
- **XSS 방지**: `innerHTML` 사용을 지양하고 `textContent`를 사용하여 결과값 렌더링
- **Input Sanitization**: 사용자 입력이 없으므로(버튼 방식) 상대적으로 안전하나, 붙여넣기 기능 지원 시 검증 필요

### 7.2 성능 최적화
- **Code Splitting**: Vite의 기본 기능을 활용하여 초기 로드 사이즈 최소화
- **Asset Optimization**: 아이콘 등 정적 자원 최적화
- **Web Vitals**: LCP, CLS, FID 지표 모니터링 및 개선

---

## 8. CI/CD 및 배포 (Deployment)

### 8.1 CI/CD 파이프라인
- **GitHub Actions**를 사용하여 자동화된 빌드 및 배포 파이프라인을 구축합니다.
- **Workflow 트리거**: `main` 브랜치에 푸시(push) 발생 시 실행

### 8.2 배포 대상 (Hosting)
- **GitHub Pages**: 정적 호스팅을 위해 사용합니다.
- Vite 빌드 설정에서 `base` 경로를 GitHub Repository 이름에 맞게 설정해야 합니다.

### 8.3 Workflow 단계
1. **Checkout**: 최신 코드 체크아웃
2. **Setup Node**: Node.js 환경 설정
3. **Install**: 의존성 패키지 설치 (`npm ci`)
4. **Build**: 프로덕션 빌드 수행 (`npm run build`)
5. **Deploy**: `gh-pages` 브랜치 또는 GitHub Pages Action을 통해 아티팩트 배포

---

## 9. 향후 확장성 (Scalability)

- **PWA 지원**: `manifest.json` 및 Service Worker 추가로 오프라인 지원
- **다국어 지원 (i18n)**: UI 텍스트의 국제화

---

## 10. 승인 (Approval)

| 역할 | 서명 | 날짜 |
|------|------|------|
| Tech Lead | Antigravity | 2025-12-23 |
