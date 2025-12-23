// Theme Handling
const themeToggleBtn = document.getElementById('theme-toggle');
const themeIcon = document.getElementById('theme-icon');
const htmlElement = document.documentElement;

function setDarkTheme(isDark) {
    if (isDark) {
        htmlElement.classList.add('dark');
        themeIcon.innerText = 'light_mode'; // 아이콘을 해 모양으로 변경
        localStorage.setItem('theme', 'dark');
    } else {
        htmlElement.classList.remove('dark');
        themeIcon.innerText = 'dark_mode'; // 아이콘을 달 모양으로 변경
        localStorage.setItem('theme', 'light');
    }
}

// Check local storage or system preference on load
const savedTheme = localStorage.getItem('theme');
const systemPrefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

if (savedTheme === 'dark' || (!savedTheme && systemPrefersDark)) {
    setDarkTheme(true);
} else {
    setDarkTheme(false);
}

themeToggleBtn.addEventListener('click', () => {
    const isDark = htmlElement.classList.contains('dark');
    setDarkTheme(!isDark);
});

const modeToggleBtn = document.getElementById('mode-toggle');
const scientificKeypad = document.getElementById('scientific-keypad');
const modeIndicator = document.getElementById('mode-indicator');

let isScientificMode = false;

modeToggleBtn.addEventListener('click', () => {
    isScientificMode = !isScientificMode;
    if (isScientificMode) {
        scientificKeypad.classList.remove('hidden');
        modeToggleBtn.classList.add('bg-primary/10', 'text-primary');
        modeToggleBtn.classList.remove('text-slate-500', 'dark:text-[#9dabb9]');
        modeIndicator.innerText = "Scientific";
    } else {
        scientificKeypad.classList.add('hidden');
        modeToggleBtn.classList.remove('bg-primary/10', 'text-primary');
        modeToggleBtn.classList.add('text-slate-500', 'dark:text-[#9dabb9]');
        modeIndicator.innerText = "Standard";
    }
});

// Calculator Logic
class Calculator {
    constructor(previousOperandTextElement, currentOperandTextElement) {
        this.previousOperandTextElement = previousOperandTextElement;
        this.currentOperandTextElement = currentOperandTextElement;
        this.clear();
        this.isDegrees = false; // Default to Radians
    }

    clear() {
        this.currentOperand = '0';
        this.previousOperand = '';
        this.operation = undefined;
    }

    delete() {
        if (this.currentOperand === 'NaN' || this.currentOperand === 'Infinity') {
            this.currentOperand = '0';
            return;
        }
        if (this.currentOperand === '0') return;
        this.currentOperand = this.currentOperand.toString().slice(0, -1);
        if (this.currentOperand === '' || this.currentOperand === '-') this.currentOperand = '0';
    }

    appendNumber(number) {
        if (this.currentOperand === 'NaN' || this.currentOperand === 'Infinity') this.clear();
        if (number === '.' && this.currentOperand.includes('.')) return;
        if (this.currentOperand === '0' && number !== '.') {
            this.currentOperand = number.toString();
        } else {
            this.currentOperand = this.currentOperand.toString() + number.toString();
        }
    }

    chooseOperation(operation) {
        if (this.currentOperand === '') return;
        if (this.previousOperand !== '') {
            this.compute();
        }
        this.operation = operation;
        this.previousOperand = this.currentOperand;
        this.currentOperand = '0';
    }

    compute() {
        let computation;
        const prev = parseFloat(this.previousOperand);
        const current = parseFloat(this.currentOperand);
        if (isNaN(prev) || isNaN(current)) return;
        switch (this.operation) {
            case '+':
                computation = prev + current;
                break;
            case '-':
                computation = prev - current;
                break;
            case '*':
                computation = prev * current;
                break;
            case '/':
                if (current === 0) {
                    this.currentOperand = 'Infinity';
                    this.operation = undefined;
                    this.previousOperand = '';
                    return;
                }
                computation = prev / current;
                break;
            case 'x^y':
                computation = Math.pow(prev, current);
                break;
            default:
                return;
        }
        this.currentOperand = computation;
        this.operation = undefined;
        this.previousOperand = '';
    }

    // Scientific Functions
    computeScientific(action) {
        let current = parseFloat(this.currentOperand);
        if (isNaN(current)) return;
        let result;

        switch (action) {
            case 'sin':
                result = this.isDegrees ? Math.sin(current * Math.PI / 180) : Math.sin(current);
                break;
            case 'cos':
                result = this.isDegrees ? Math.cos(current * Math.PI / 180) : Math.cos(current);
                break;
            case 'tan':
                result = this.isDegrees ? Math.tan(current * Math.PI / 180) : Math.tan(current);
                break;
            case 'ln':
                if (current <= 0) {
                    alert("정의되지 않은 입력입니다."); // 간단한 에러
                    return;
                }
                result = Math.log(current);
                break;
            case 'log':
                if (current <= 0) {
                    alert("정의되지 않은 입력입니다.");
                    return;
                }
                result = Math.log10(current);
                break;
            case 'sq':
                result = Math.pow(current, 2);
                break;
            case 'sqrt':
                if (current < 0) {
                    alert("허수는 지원하지 않습니다.");
                    return;
                }
                result = Math.sqrt(current);
                break;
            case 'inv':
                if (current === 0) {
                    alert("0으로 나눌 수 없습니다.");
                    return;
                }
                result = 1 / current;
                break;
            case 'exp': // e constant inputs
                this.currentOperand = Math.E.toString();
                return;
            case 'pi':
                this.currentOperand = Math.PI.toString();
                return;
            case 'pow': // 이항 연산 처리 필요
                this.chooseOperation('x^y');
                return;
            case 'deg':
                // Toggle Deg/Rad
                this.isDegrees = !this.isDegrees;
                const btn = document.querySelector('[data-scientific="deg"]');
                if (btn) btn.innerText = this.isDegrees ? 'rad' : 'deg'; // 보여줄 텍스트: 다음 상태
                return;
            default:
                return;
        }

        // 결과를 현재 오퍼랜드에 반영 (단항 연산의 경우)
        // 계산된 값은 정밀도 문제 해결을 위해 약간의 처리 필요할 수 있음
        // 여기서는 간단히 처리
        if (result !== undefined) {
            // 부동 소수점 오차 보정 (예: sin(PI)가 0이 아닌 아주 작은 수가 나오는 문제)
            if (Math.abs(result) < 1e-10) result = 0;
            this.currentOperand = result;
            // 계산 완료 후 이전 기록 리셋하지 않음 (연속 계산 가능)
        }
    }

    negate() {
        if (this.currentOperand === '0') return;
        this.currentOperand = (parseFloat(this.currentOperand) * -1).toString();
    }

    percentage() {
        this.currentOperand = (parseFloat(this.currentOperand) / 100).toString();
    }

    getDisplayNumber(number) {
        if (number === 'Infinity') return 'Infinity';
        if (number === 'NaN') return 'Error';
        const stringNumber = number.toString();
        const integerDigits = parseFloat(stringNumber.split('.')[0]);
        const decimalDigits = stringNumber.split('.')[1];
        let integerDisplay;
        if (isNaN(integerDigits)) {
            integerDisplay = '';
        } else {
            integerDisplay = integerDigits.toLocaleString('en', { maximumFractionDigits: 0 });
        }
        if (decimalDigits != null) {
            return `${integerDisplay}.${decimalDigits}`;
        } else {
            return integerDisplay;
        }
    }

    updateDisplay() {
        this.currentOperandTextElement.innerText = this.getDisplayNumber(this.currentOperand);
        if (this.operation != null) {
            const operationSymbols = {
                '+': '+',
                '-': '-',
                '*': '×',
                '/': '÷',
                'x^y': '^'
            };
            this.previousOperandTextElement.innerText =
                `${this.getDisplayNumber(this.previousOperand)} ${operationSymbols[this.operation] || ''}`;
        } else {
            this.previousOperandTextElement.innerText = '';
        }
    }
}

// DOM Elements
const numberButtons = document.querySelectorAll('[data-number]');
const operationButtons = document.querySelectorAll('[data-operation]');
const scientificButtons = document.querySelectorAll('[data-scientific]'); // 추가
const equalsButton = document.querySelector('[data-action="calculate"]');
const deleteButton = document.querySelector('[data-action="delete"]');
const allClearButton = document.querySelector('[data-action="clear"]');
const negateButton = document.querySelector('[data-action="negate"]');
const percentButton = document.querySelector('[data-action="percent"]');
const previousOperandTextElement = document.getElementById('previous-operand');
const currentOperandTextElement = document.getElementById('current-operand');

// Initialize Calculator
const calculator = new Calculator(previousOperandTextElement, currentOperandTextElement);

// Event Listeners
numberButtons.forEach(button => {
    button.addEventListener('click', () => {
        calculator.appendNumber(button.dataset.number);
        calculator.updateDisplay();
    });
});

operationButtons.forEach(button => {
    button.addEventListener('click', () => {
        calculator.chooseOperation(button.dataset.operation);
        calculator.updateDisplay();
    });
});

// Scientific Buttons Listener
scientificButtons.forEach(button => {
    button.addEventListener('click', () => {
        calculator.computeScientific(button.dataset.scientific);
        calculator.updateDisplay();
    });
});

equalsButton.addEventListener('click', () => {
    calculator.compute();
    calculator.updateDisplay();
});

allClearButton.addEventListener('click', () => {
    calculator.clear();
    calculator.updateDisplay();
});

deleteButton.addEventListener('click', () => {
    calculator.delete();
    calculator.updateDisplay();
});

negateButton.addEventListener('click', () => {
    calculator.negate();
    calculator.updateDisplay();
});

percentButton.addEventListener('click', () => {
    calculator.percentage();
    calculator.updateDisplay();
});

// Keyboard Support (Optional but good for UX)
document.addEventListener('keydown', (e) => {
    if ((e.key >= 0 && e.key <= 9) || e.key === '.') {
        calculator.appendNumber(e.key);
        calculator.updateDisplay();
    }
    if (e.key === 'Enter' || e.key === '=') {
        e.preventDefault(); // Enter might trigger focused button
        calculator.compute();
        calculator.updateDisplay();
    }
    if (e.key === 'Backspace') {
        calculator.delete();
        calculator.updateDisplay();
    }
    if (e.key === 'Escape') {
        calculator.clear();
        calculator.updateDisplay();
    }
    if (e.key === '+' || e.key === '-' || e.key === '*' || e.key === '/') {
        calculator.chooseOperation(e.key);
        calculator.updateDisplay();
    }
});
