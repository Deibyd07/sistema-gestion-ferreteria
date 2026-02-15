/** @type {import('tailwindcss').Config} */
export default {
    content: [
        "./index.html",
        "./src/**/*.{vue,js,ts,jsx,tsx}",
    ],
    theme: {
        extend: {
            colors: {
                // Dark Surfaces
                surface: {
                    base: '#0b1120',
                    elevated: '#141b2d',
                    border: '#1e293b',
                    0: '#0f172a',
                    1: '#1a2332',
                    2: '#1e293b',
                    3: '#273548',
                    4: '#334155',
                },
                // Teal Accent (Primary)
                accent: {
                    50: '#ecfdf5',
                    100: '#ccfbf1',
                    200: '#99f6e4',
                    300: '#5eead4',
                    400: '#2dd4bf',
                    500: '#14b8a6',
                    600: '#0d9488',
                    700: '#0f766e',
                    800: '#115e59',
                    900: '#134e4a',
                },
                // Cyan Complement
                cyan: {
                    300: '#67e8f9',
                    400: '#22d3ee',
                    500: '#06b6d4',
                    600: '#0891b2',
                },
                // Violet Accent
                violet: {
                    300: '#c4b5fd',
                    400: '#a78bfa',
                    500: '#8b5cf6',
                    600: '#7c3aed',
                },
                // Slate (Text & Neutral)
                slate: {
                    50: '#f8fafc',
                    100: '#f1f5f9',
                    200: '#e2e8f0',
                    300: '#cbd5e1',
                    400: '#94a3b8',
                    500: '#64748b',
                    600: '#475569',
                    700: '#334155',
                    800: '#1e293b',
                    900: '#0f172a',
                    950: '#020617',
                },
                // Status
                success: {
                    DEFAULT: '#10b981',
                    50: '#ecfdf5',
                    400: '#34d399',
                    500: '#10b981',
                    600: '#059669',
                },
                danger: {
                    DEFAULT: '#f43f5e',
                    50: '#fff1f2',
                    400: '#fb7185',
                    500: '#f43f5e',
                    600: '#e11d48',
                },
                warning: {
                    DEFAULT: '#f59e0b',
                    50: '#fffbeb',
                    400: '#fbbf24',
                    500: '#f59e0b',
                    600: '#d97706',
                },
            },
            fontFamily: {
                sans: ['Inter', 'system-ui', '-apple-system', 'sans-serif'],
                display: ['Plus Jakarta Sans', 'Inter', 'system-ui', 'sans-serif'],
            },
            fontSize: {
                xs: ['0.75rem', { lineHeight: '1rem' }],
                sm: ['0.875rem', { lineHeight: '1.25rem' }],
                base: ['1rem', { lineHeight: '1.5rem' }],
                lg: ['1.125rem', { lineHeight: '1.75rem' }],
                xl: ['1.25rem', { lineHeight: '1.75rem' }],
                '2xl': ['1.5rem', { lineHeight: '2rem' }],
                '3xl': ['1.875rem', { lineHeight: '2.25rem' }],
                '4xl': ['2.25rem', { lineHeight: '2.5rem' }],
                '5xl': ['3rem', { lineHeight: '1.15' }],
            },
            borderRadius: {
                sm: '0.375rem',
                base: '0.5rem',
                md: '0.75rem',
                lg: '1rem',
                xl: '1.25rem',
                '2xl': '1.5rem',
                '3xl': '2rem',
            },
            boxShadow: {
                // Glow effects - Para elementos accent
                'glow-sm': '0 0 10px rgba(20, 184, 166, 0.15), 0 0 25px rgba(20, 184, 166, 0.05)',
                'glow': '0 0 20px rgba(20, 184, 166, 0.2), 0 0 60px rgba(20, 184, 166, 0.08)',
                'glow-lg': '0 0 35px rgba(20, 184, 166, 0.3), 0 0 90px rgba(20, 184, 166, 0.12)',
                'glow-xl': '0 0 50px rgba(20, 184, 166, 0.4), 0 0 120px rgba(20, 184, 166, 0.15)',
                
                // Dark theme shadows - Más profundidad
                'dark-xs': '0 1px 2px rgba(0, 0, 0, 0.35)',
                'dark-sm': '0 2px 4px rgba(0, 0, 0, 0.4), 0 1px 2px rgba(0, 0, 0, 0.3)',
                'dark-md': '0 4px 14px rgba(0, 0, 0, 0.45), 0 2px 6px rgba(0, 0, 0, 0.35)',
                'dark-lg': '0 12px 36px rgba(0, 0, 0, 0.5), 0 4px 14px rgba(0, 0, 0, 0.4)',
                'dark-xl': '0 20px 50px rgba(0, 0, 0, 0.6), 0 8px 20px rgba(0, 0, 0, 0.45)',
                'dark-2xl': '0 30px 70px rgba(0, 0, 0, 0.7)',
                
                // Colored shadows - Para status y alerts
                'success': '0 10px 30px rgba(16, 185, 129, 0.15)',
                'danger': '0 10px 30px rgba(244, 63, 94, 0.15)',
                'warning': '0 10px 30px rgba(245, 158, 11, 0.15)',
                
                // Inner shadows - Para inputs y wells
                'inner-dark': 'inset 0 2px 8px rgba(0, 0, 0, 0.3)',
                'inner-glow': 'inset 0 0 0 1px rgba(20, 184, 166, 0.1), 0 0 20px rgba(20, 184, 166, 0.1)',
            },
            animation: {
                // Enter/Exit animations
                'fade-in': 'fadeIn 400ms cubic-bezier(0.16, 1, 0.3, 1) both',
                'fade-out': 'fadeOut 250ms ease-out both',
                'slide-up': 'slideUp 500ms cubic-bezier(0.16, 1, 0.3, 1) both',
                'slide-down': 'slideDown 400ms cubic-bezier(0.16, 1, 0.3, 1) both',
                'slide-left': 'slideLeft 400ms cubic-bezier(0.16, 1, 0.3, 1) both',
                'slide-right': 'slideRight 400ms cubic-bezier(0.16, 1, 0.3, 1) both',
                'scale-in': 'scaleIn 350ms cubic-bezier(0.16, 1, 0.3, 1) both',
                'scale-out': 'scaleOut 200ms ease-in both',
                
                // Continuous animations
                'float': 'float 6s ease-in-out infinite',
                'float-slow': 'floatSlow 8s ease-in-out infinite',
                'pulse-subtle': 'pulseSubtle 3s ease-in-out infinite',
                'glow-pulse': 'glowPulse 3s ease-in-out infinite',
                'bounce-subtle': 'bounceSubtle 2s ease-in-out infinite',
                'spin-slow': 'spin 12s linear infinite',
                'spin-slower': 'spin 20s linear infinite',
                
                // Number animations
                'count-up': 'countUp 800ms cubic-bezier(0.16, 1, 0.3, 1) both',
                
                // Attention seekers
                'shake': 'shake 400ms ease-in-out',
                'wiggle': 'wiggle 500ms ease-in-out',
                'ping-once': 'ping 600ms cubic-bezier(0, 0, 0.2, 1)',
                
                // Sophisticated effects
                'shine': 'shine 3s ease-in-out infinite',
                'shimmer': 'shimmer 2s infinite',
                'gradient-shift': 'gradientShift 8s ease infinite',
                
                // Progress
                'progress': 'progress 1s linear',
                'progress-indeterminate': 'progressIndeterminate 1.5s ease-in-out infinite',
                
                // Stagger (use with delay utilities)
                'stagger-1': 'slideUp 500ms cubic-bezier(0.16, 1, 0.3, 1) both',
                'stagger-2': 'slideUp 500ms cubic-bezier(0.16, 1, 0.3, 1) 100ms both',
                'stagger-3': 'slideUp 500ms cubic-bezier(0.16, 1, 0.3, 1) 200ms both',
                'stagger-4': 'slideUp 500ms cubic-bezier(0.16, 1, 0.3, 1) 300ms both',
            },
            keyframes: {
                // Basic enters
                fadeIn: {
                    from: { opacity: '0' },
                    to: { opacity: '1' },
                },
                fadeOut: {
                    from: { opacity: '1' },
                    to: { opacity: '0' },
                },
                slideUp: {
                    from: { transform: 'translateY(24px)', opacity: '0' },
                    to: { transform: 'translateY(0)', opacity: '1' },
                },
                slideDown: {
                    from: { transform: 'translateY(-24px)', opacity: '0' },
                    to: { transform: 'translateY(0)', opacity: '1' },
                },
                slideLeft: {
                    from: { transform: 'translateX(24px)', opacity: '0' },
                    to: { transform: 'translateX(0)', opacity: '1' },
                },
                slideRight: {
                    from: { transform: 'translateX(-24px)', opacity: '0' },
                    to: { transform: 'translateX(0)', opacity: '1' },
                },
                scaleIn: {
                    from: { transform: 'scale(0.9)', opacity: '0' },
                    to: { transform: 'scale(1)', opacity: '1' },
                },
                scaleOut: {
                    from: { transform: 'scale(1)', opacity: '1' },
                    to: { transform: 'scale(0.9)', opacity: '0' },
                },
                
                // Continuous effects
                float: {
                    '0%, 100%': { transform: 'translateY(0) rotate(0deg)' },
                    '33%': { transform: 'translateY(-12px) rotate(1deg)' },
                    '66%': { transform: 'translateY(-6px) rotate(-1deg)' },
                },
                floatSlow: {
                    '0%, 100%': { transform: 'translateY(0) rotate(0deg) scale(1)' },
                    '50%': { transform: 'translateY(-20px) rotate(2deg) scale(1.02)' },
                },
                pulseSubtle: {
                    '0%, 100%': { opacity: '1', transform: 'scale(1)' },
                    '50%': { opacity: '0.9', transform: 'scale(0.98)' },
                },
                glowPulse: {
                    '0%, 100%': { 
                        boxShadow: '0 0 20px rgba(20, 184, 166, 0.2), 0 0 60px rgba(20, 184, 166, 0.08)' 
                    },
                    '50%': { 
                        boxShadow: '0 0 40px rgba(20, 184, 166, 0.4), 0 0 90px rgba(20, 184, 166, 0.15)' 
                    },
                },
                bounceSubtle: {
                    '0%, 100%': { transform: 'translateY(0)' },
                    '50%': { transform: 'translateY(-6px)' },
                },
                
                // Number effects
                countUp: {
                    from: { 
                        transform: 'translateY(8px)', 
                        opacity: '0',
                        filter: 'blur(4px)'
                    },
                    to: { 
                        transform: 'translateY(0)', 
                        opacity: '1',
                        filter: 'blur(0)'
                    },
                },
                
                // Attention
                shake: {
                    '0%, 100%': { transform: 'translateX(0)' },
                    '10%, 30%, 50%, 70%, 90%': { transform: 'translateX(-4px)' },
                    '20%, 40%, 60%, 80%': { transform: 'translateX(4px)' },
                },
                wiggle: {
                    '0%, 100%': { transform: 'rotate(0deg)' },
                    '25%': { transform: 'rotate(-3deg)' },
                    '75%': { transform: 'rotate(3deg)' },
                },
                
                // Sophisticated
                shine: {
                    '0%': { backgroundPosition: '200% center' },
                    '100%': { backgroundPosition: '-200% center' },
                },
                shimmer: {
                    '0%': { transform: 'translateX(-100%)' },
                    '100%': { transform: 'translateX(100%)' },
                },
                gradientShift: {
                    '0%, 100%': { backgroundPosition: '0% 50%' },
                    '50%': { backgroundPosition: '100% 50%' },
                },
                
                // Progress
                progress: {
                    from: { width: '0%' },
                    to: { width: '100%' },
                },
                progressIndeterminate: {
                    '0%': { transform: 'translateX(-100%)' },
                    '50%': { transform: 'translateX(100%)' },
                    '100%': { transform: 'translateX(-100%)' },
                },
            },
            // Backdrop blur levels
            backdropBlur: {
                xs: '2px',
                sm: '4px',
                DEFAULT: '8px',
                md: '12px',
                lg: '16px',
                xl: '24px',
                '2xl': '40px',
                '3xl': '64px',
            },
            // Transition timing functions
            transitionTimingFunction: {
                'bounce-in': 'cubic-bezier(0.68, -0.55, 0.265, 1.55)',
                'ease-spring': 'cubic-bezier(0.16, 1, 0.3, 1)',
                'ease-smooth': 'cubic-bezier(0.4, 0, 0.2, 1)',
            },
            // Z-index scale
            zIndex: {
                '60': '60',
                '70': '70',
                '80': '80',
                '90': '90',
                '100': '100',
            },
        },
    },
    plugins: [],
}
