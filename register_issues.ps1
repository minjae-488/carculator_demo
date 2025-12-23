$issues = @(
    @{
        Title = "[Phase 1] 1.1 프로젝트 스캐폴딩"
        Body = "## 작업 배경 (Background)`n프로젝트의 기반이 되는 Vite와 Tailwind CSS 환경을 설정하여 개발 준비를 마칩니다.`n`n## 작업 내용 (Tasks)`n- [ ] Vite 프로젝트 초기화 (Vanilla JS + 기본 파일 정리)`n- [ ] Tailwind CSS 설치 및 설정 (디자인 토큰으로 tailwind.config.js 업데이트)`n- [ ] vitest 환경 설정`n- [ ] 디렉토리 구조에 따른 절대 경로 별칭(Alias) 설정 (필요 시)`n`n## 인수 조건 (Acceptance Criteria)`n- [ ] Vite 개발 서버가 오류 없이 실행되어야 합니다.`n- [ ] Tailwind 유틸리티 클래스가 정상적으로 스타일을 적용해야 합니다.`n- [ ] npm test 명령어로 Vitest가 실행되어야 합니다."
    },
    @{
        Title = "[Phase 1] 1.2 의존성 라이브러리 설정"
        Body = "## 작업 배경 (Background)`n정밀한 계산과 테스트를 위해 필요한 핵심 라이브러리들을 설치하고 설정합니다.`n`n## 작업 내용 (Tasks)`n- [ ] 프로덕션 의존성 설치: decimal.js`n- [ ] 개발 의존성 설치: vitest (코어 로직 테스트용)`n- [ ] .agent/rules/project_rules.md 생성 (완료됨)`n`n## 인수 조건 (Acceptance Criteria)`n- [ ] package.json에 decimal.js와 vitest가 포함되어야 합니다.`n- [ ] node_modules가 정상적으로 설치되어야 합니다."
    },
    @{
        Title = "[Phase 1] 1.3 CI/CD 설정"
        Body = "## 작업 배경 (Background)`n지속적인 통합과 배포를 위해 GitHub Actions와 GitHub Pages를 설정합니다.`n`n## 작업 내용 (Tasks)`n- [ ] .github/workflows/deploy.yml 파일 확인`n- [ ] 초기 커밋 및 main 브랜치 푸시`n`n## 인수 조건 (Acceptance Criteria)`n- [ ] main 브랜치에 푸시 시 GitHub Actions 워크플로우가 성공해야 합니다.`n- [ ] GitHub Pages에 빌드된 결과물이 배포되어야 합니다."
    },
    @{
        Title = "[Phase 2] 2.1 수학 연산 모듈 구현 (TDD)"
        Body = "## 작업 배경 (Background)`n계산기의 가장 기본이 되는 사칙연산 기능을 TDD 방식으로 구현합니다.`n`n## 작업 내용 (Tasks)`n- [ ] 테스트 및 구현: 기본 사칙연산 (+, -, *, /)`n- [ ] 테스트 및 구현: 0으로 나누기 예외 처리`n- [ ] 테스트 및 구현: 정밀도 처리 (decimal.js 사용)`n`n## 인수 조건 (Acceptance Criteria)`n- [ ] 모든 사칙연산 단위 테스트가 통과해야 합니다.`n- [ ] 0.1 + 0.2가 정확히 0.3이 되어야 합니다.`n- [ ] 0으로 나누기 시도 시 적절한 에러(Infinity 또는 Error)를 반환해야 합니다."
    },
    @{
        Title = "[Phase 2] 2.2 공학 연산 모듈 구현 (TDD)"
        Body = "## 작업 배경 (Background)`n공학용 계산기에 필요한 삼각함수, 로그, 지수 함수를 TDD로 구현합니다.`n`n## 작업 내용 (Tasks)`n- [ ] 테스트 및 구현: 삼각함수 (sin, cos, tan - 라디안/도 처리)`n- [ ] 테스트 및 구현: 로그 및 지수 함수`n`n## 인수 조건 (Acceptance Criteria)`n- [ ] 삼각함수 및 공학 함수에 대한 단위 테스트가 통과해야 합니다.`n- [ ] 라디안과 도(Degree) 모드에 따라 정확한 삼각함수 값을 반환해야 합니다."
    },
    @{
        Title = "[Phase 2] 2.3 계산기 엔진 상태 머신 구현 (TDD)"
        Body = "## 작업 배경 (Background)`n입력, 연산자 선택, 결과 계산 등의 상태를 관리하는 엔진을 구현합니다.`n`n## 작업 내용 (Tasks)`n**상태 구조 정의**`n- [ ] 상태 객체 정의 (currentValue, previousValue, operator, isFinished)`n`n**입력 처리**`n- [ ] 테스트 및 구현: 숫자 입력 (초기 '0' 처리 포함)`n- [ ] 테스트 및 구현: 소수점 입력 (중복 방지)`n`n**연산 처리**`n- [ ] 테스트 및 구현: 연산자 선택 (연속 계산 처리)`n- [ ] 테스트 및 구현: 등호 (=) 실행 로직`n`n**편집 기능 처리**`n- [ ] 테스트 및 구현: 초기화 (AC) - 모든 상태 리셋`n- [ ] 테스트 및 구현: 백스페이스 - 마지막 입력 숫자 삭제`n- [ ] 테스트 및 구현: 부호 변경 (+/-) 및 퍼센트 (%)`n`n## 인수 조건 (Acceptance Criteria)`n- [ ] 숫자 입력, 연산자 선택, 등호 입력 시나리오에 대한 테스트가 통과해야 합니다.`n- [ ] 연속 계산(예: 1 + 2 + 3 =)이 정상 동작해야 합니다.`n- [ ] AC 및 백스페이스 기능이 상태를 올바르게 변경해야 합니다."
    },
    @{
        Title = "[Phase 3] 3.1 전역 스타일 및 Tailwind 설정"
        Body = "## 작업 배경 (Background)`n일관된 디자인 시스템 적용을 위해 Tailwind CSS 설정과 전역 스타일을 정의합니다.`n`n## 작업 내용 (Tasks)`n- [ ] 컬러 팔레트 정의 (Primary, Backgrounds - 라이트/다크) index.css / config`n- [ ] 타이포그래피 설정 (폰트 패밀리: 'Space Grotesk')`n`n## 인수 조건 (Acceptance Criteria)`n- [ ] Tailwind config에 커스텀 컬러와 폰트가 정의되어야 합니다.`n- [ ] index.css에 기본 폰트가 적용되어야 합니다."
    },
    @{
        Title = "[Phase 3] 3.2 레이아웃 스켈레톤"
        Body = "## 작업 배경 (Background)`n반응형 웹 앱의 기본 레이아웃 구조를 잡고 다크 모드를 지원합니다.`n`n## 작업 내용 (Tasks)`n- [ ] 반응형 컨테이너 생성 (모바일 프레임 중앙 정렬)`n- [ ] 다크/라이트 모드 전환 로직 구현 (클래스 토글링)`n`n## 인수 조건 (Acceptance Criteria)`n- [ ] 화면 중앙에 모바일 비율의 프레임이 위치해야 합니다.`n- [ ] 테마 전환 시 배경색과 텍스트 색상이 변경되어야 합니다."
    },
    @{
        Title = "[Phase 4] 4.1 디스플레이 컴포넌트"
        Body = "## 작업 배경 (Background)`n계산 결과와 히스토리를 보여주는 디스플레이 영역을 구현합니다.`n`n## 작업 내용 (Tasks)`n- [ ] HTML 구조 (결과값 + 히스토리/메타 텍스트)`n- [ ] 스타일: 긴 숫자에 대한 폰트 크기 자동 조절`n- [ ] 통합: Calculator 상태 업데이트와 연동`n`n## 인수 조건 (Acceptance Criteria)`n- [ ] 입력값에 따라 숫자가 표시되어야 합니다.`n- [ ] 숫자가 길어지면 폰트 크기가 줄어들거나 말줄임표 처리되어야 합니다.`n- [ ] 상단에 연산 과정(메타 텍스트)이 표시되어야 합니다."
    },
    @{
        Title = "[Phase 4] 4.2 키패드 컴포넌트 (표준)"
        Body = "## 작업 배경 (Background)`n기본적인 숫자 및 사칙연산 버튼 그리드를 구현합니다.`n`n## 작업 내용 (Tasks)`n- [ ] HTML 그리드 레이아웃`n- [ ] 버튼: 재사용 가능한 버튼 스타일 생성 (숫자 vs 연산자 vs 액션)`n- [ ] 통합: 클릭 이벤트를 Calculator 메서드에 매핑`n`n## 인수 조건 (Acceptance Criteria)`n- [ ] 4열 그리드 레이아웃이 디자인과 일치해야 합니다.`n- [ ] 버튼 클릭 시 적절한 시각적 반응(Hover/Active)이 있어야 합니다.`n- [ ] 버튼 클릭 시 계산기 엔진의 기능이 실행되어야 합니다."
    },
    @{
        Title = "[Phase 4] 4.3 키패드 컴포넌트 (확장/공학)"
        Body = "## 작업 배경 (Background)`n공학용 계산을 위한 추가 버튼들과 모드 전환 기능을 구현합니다.`n`n## 작업 내용 (Tasks)`n- [ ] 모드 전환 버튼 구현 (표준 <-> 공학)`n- [ ] 공학용 버튼 그리드 추가 (전환 애니메이션 적용)`n`n## 인수 조건 (Acceptance Criteria)`n- [ ] 공학 모드 버튼 클릭 시 확장 키패드가 표시되어야 합니다.`n- [ ] 삼각함수, 로그 등 공학 연산 로직이 연결되어야 합니다."
    },
    @{
        Title = "[Phase 4] 4.4 히스토리 기능"
        Body = "## 작업 배경 (Background)`n사용자가 이전 계산 기록을 확인하고 재사용할 수 있도록 합니다.`n`n## 작업 내용 (Tasks)`n- [ ] HistoryManager 클래스 구현 (LocalStorage 래퍼)`n- [ ] UI: 히스토리 사이드바/오버레이 생성`n- [ ] 통합: 계산 완료 시 저장, 항목 클릭 시 불러오기`n`n## 인수 조건 (Acceptance Criteria)`n- [ ] 계산 완료 시 LocalStorage에 기록이 저장되어야 합니다.`n- [ ] 페이지 새로고침 후에도 기록이 유지되어야 합니다.`n- [ ] 히스토리 항목 클릭 시 해당 결과값이 입력되어야 합니다."
    },
    @{
        Title = "[Phase 5] 5.1 키보드 지원 및 접근성"
        Body = "## 작업 배경 (Background)`n모든 사용자가 편리하게 사용할 수 있도록 키보드 입력과 접근성을 지원합니다.`n`n## 작업 내용 (Tasks)`n- [ ] 실제 키보드 키를 계산기 버튼에 매핑`n- [ ] 키 입력 시 시각적 피드백 (Active 상태) 추가`n- [ ] 아이콘 버튼에 aria-label 추가`n- [ ] 키보드 네비게이션을 위한 포커스 관리 확인`n`n## 인수 조건 (Acceptance Criteria)`n- [ ] 물리 키보드의 숫자패드와 엔터키로 계산이 가능해야 합니다.`n- [ ] 스크린 리더가 버튼의 기능을 명확히 읽어주어야 합니다."
    },
    @{
        Title = "[Phase 5] 5.2 애니메이션 및 완성도 (Polish)"
        Body = "## 작업 배경 (Background)`n사용자 경험을 향상시키기 위해 부드러운 애니메이션과 마무리를 진행합니다.`n`n## 작업 내용 (Tasks)`n- [ ] 버튼 클릭 애니메이션 (스케일/밝기) 추가`n- [ ] 테마 전환 및 모드 전환 시 부드러운 트랜지션 적용`n- [ ] 전체 유닛 테스트 실행 (npm test)`n- [ ] 수동 테스트: 레퍼런스(예: 구글 계산기)와 계산 결과 비교`n- [ ] 모바일 반응형 확인`n`n## 인수 조건 (Acceptance Criteria)`n- [ ] UI 인터랙션이 부드럽고 자연스러워야 합니다.`n- [ ] 모바일 및 데스크톱 환경에서 레이아웃이 깨지지 않아야 합니다."
    },
    @{
        Title = "[Phase 6] 6.1 문서화 및 배포"
        Body = "## 작업 배경 (Background)`n프로젝트를 마무리하고 배포하며 문서를 정리합니다.`n`n## 작업 내용 (Tasks)`n- [ ] README 업데이트 (사용법 및 개발 방법)`n- [ ] 최종 배포 및 확인`n`n## 인수 조건 (Acceptance Criteria)`n- [ ] README에 프로젝트 실행 방법과 기능 설명이 포함되어야 합니다.`n- [ ] GitHub Pages에서 실제 사용 가능한 상태여야 합니다."
    }
)

foreach ($issue in $issues) {
    Write-Host "Creating issue: $($issue.Title)"
    gh issue create --title $issue.Title --body $issue.Body
    Start-Sleep -Seconds 2
}
