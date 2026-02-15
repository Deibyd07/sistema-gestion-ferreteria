<template>
  <div
    ref="containerRef"
    class="relative min-h-screen bg-[#0A0E17] overflow-hidden"
    :class="[customCursorEnabled ? 'cursor-none' : 'cursor-auto', lowPerfMode ? 'low-perf' : '']"
  >
    <!-- Custom Cursor -->
    <div
      v-if="customCursorEnabled"
      class="fixed w-8 h-8 rounded-full border-2 border-accent-400 pointer-events-none transition-transform duration-150 ease-out z-[9999] mix-blend-difference"
      :style="{
        left: `${mouseX}px`,
        top: `${mouseY}px`,
        opacity: cursorVisible ? 1 : 0,
        transform: `translate(-50%, -50%) scale(${cursorScale})`,
      }"
    ></div>
    <div
      v-if="customCursorEnabled"
      class="fixed w-2 h-2 rounded-full bg-accent-400 pointer-events-none z-[9999] mix-blend-difference"
      :style="{
        left: `${mouseX}px`,
        top: `${mouseY}px`,
        opacity: cursorVisible ? 1 : 0,
        transform: 'translate(-50%, -50%)',
      }"
    ></div>

    <!-- Mouse Spotlight Effect -->
    <div 
      ref="spotlightRef"
      v-if="!lowPerfMode"
      class="fixed w-[800px] h-[800px] rounded-full pointer-events-none transition-opacity duration-300 z-0"
      :style="{
        left: `${mouseX}px`,
        top: `${mouseY}px`,
        transform: 'translate(-50%, -50%)',
        background: 'radial-gradient(circle, rgba(20, 184, 166, 0.08) 0%, transparent 70%)',
        opacity: isHovering ? 1 : 0
      }"
    ></div>

    <!-- Cursor Trail Effect -->
    <div
      v-if="customCursorEnabled && !lowPerfMode"
      v-for="(particle, index) in cursorTrail"
      :key="index"
      class="fixed w-1 h-1 rounded-full bg-cyan-400 pointer-events-none z-[9998]"
      :style="{
        left: `${particle.x}px`,
        top: `${particle.y}px`,
        opacity: particle.opacity,
        transform: 'translate(-50%, -50%)',
      }"
    ></div>

    <!-- Click Particle Explosion -->
    <div
      v-if="customCursorEnabled && !lowPerfMode"
      v-for="(particle, index) in clickParticles"
      :key="`click-${index}`"
      class="fixed w-2 h-2 rounded-full pointer-events-none z-[9998]"
      :style="{
        left: `${particle.x}px`,
        top: `${particle.y}px`,
        background: particle.color,
        opacity: particle.opacity,
        transform: `translate(-50%, -50%) scale(${particle.scale})`,
        transition: 'all 0.1s ease-out'
      }"
    ></div>

    <!-- Aurora Borealis Effect -->
    <div v-if="!lowPerfMode" class="fixed inset-0 overflow-hidden pointer-events-none z-0">
      <div 
        class="absolute w-full h-full"
        style="
          background: 
            radial-gradient(ellipse 80% 50% at 50% -20%, rgba(20, 184, 166, 0.15), transparent),
            radial-gradient(ellipse 60% 50% at 80% 50%, rgba(139, 92, 246, 0.10), transparent),
            radial-gradient(ellipse 60% 50% at 20% 80%, rgba(34, 211, 238, 0.10), transparent);
          animation: aurora 15s ease-in-out infinite;
        "
      ></div>
    </div>

    <!-- Cinematic Overlays -->
    <div class="fixed inset-0 pointer-events-none z-0 cinematic-vignette"></div>
    <div v-if="!lowPerfMode" class="fixed inset-0 pointer-events-none z-0 film-grain opacity-20"></div>

    <!-- Sophisticated Background -->
    <div class="fixed inset-0 overflow-hidden pointer-events-none">
      <!-- Animated Mesh Gradients with Parallax -->
      <div 
        class="absolute top-0 left-0 right-0 h-[600px] bg-gradient-to-b from-accent-500/5 via-cyan-500/5 to-transparent blur-3xl animate-float"
        style="animation-duration: 8s;"
        :style="{ transform: `translateY(${scrollY * 0.3}px)` }"
      ></div>
      <div 
        class="absolute bottom-0 left-0 w-[600px] h-[600px] bg-violet-500/5 rounded-full blur-3xl animate-float-slow"
        style="animation-duration: 12s; animation-delay: -2s;"
        :style="{ transform: `translateY(${scrollY * -0.2}px) translateX(${scrollY * 0.1}px)` }"
      ></div>
      <div 
        class="absolute top-1/2 right-0 w-[500px] h-[500px] bg-cyan-500/5 rounded-full blur-3xl animate-float"
        style="animation-duration: 10s; animation-delay: -4s;"
        :style="{ transform: `translateY(${scrollY * 0.15}px) translateX(${scrollY * -0.1}px)` }"
      ></div>
      
      <!-- Animated Grid -->
      <div class="absolute inset-0 animate-pulse-subtle" style="background-image: radial-gradient(circle at 1px 1px, rgba(148, 163, 184, 0.05) 1px, transparent 0); background-size: 40px 40px;"></div>
      
      <!-- Floating Particles -->
      <div
        v-if="!lowPerfMode"
        v-for="n in 20"
        :key="n"
        class="absolute w-1 h-1 rounded-full bg-accent-400/20"
        :style="{
          left: `${Math.random() * 100}%`,
          top: `${Math.random() * 100}%`,
          animation: `float ${5 + Math.random() * 5}s ease-in-out infinite`,
          animationDelay: `${Math.random() * 5}s`
        }"
      ></div>
    </div>

    <div class="relative z-10">
      <!-- Navigation -->
      <nav 
        class="border-b backdrop-blur-xl sticky top-0 z-50 transition-all duration-500"
        :class="scrollY > 50 ? 'border-white/10 bg-[#0A0E17]/95 shadow-2xl shadow-black/20' : 'border-white/5 bg-[#0A0E17]/80'"
      >
        <!-- Scroll Progress Bar -->
        <div class="absolute bottom-0 left-0 h-0.5 bg-gradient-to-r from-accent-400 via-cyan-400 to-violet-400 transition-all duration-300" :style="{ width: `${scrollProgress}%` }"></div>
        
        <div class="max-w-7xl mx-auto px-6 lg:px-8">
          <div class="flex items-center justify-between h-16">
            <div class="flex items-center gap-3 group cursor-pointer">
              <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-accent-400 to-cyan-500 flex items-center justify-center group-hover:scale-110 transition-transform duration-300 shadow-lg shadow-accent-500/20 group-hover:shadow-accent-500/40">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                </svg>
              </div>
              <span class="text-lg font-semibold text-white tracking-tight">FerreCloud</span>
            </div>
            
            <div class="flex items-center gap-8 text-sm">
              <a href="#components" class="text-slate-400 hover:text-white transition-all hover:translate-y-[-2px]">Components</a>
              <a href="#patterns" class="text-slate-400 hover:text-white transition-all hover:translate-y-[-2px]">Patterns</a>
              <a href="#docs" class="text-slate-400 hover:text-white transition-all hover:translate-y-[-2px]">Docs</a>
              <button
                @click="toggleAmbientSound"
                class="flex items-center gap-2 px-3 py-1.5 rounded-lg border border-white/10 bg-white/5 hover:bg-white/10 text-slate-300 hover:text-white transition-all"
              >
                <span class="w-2 h-2 rounded-full" :class="audioEnabled ? 'bg-emerald-400' : 'bg-slate-500'"></span>
                <span>Ambient</span>
              </button>
              <button class="relative px-4 py-2 rounded-lg bg-white/5 hover:bg-white/10 text-white text-sm font-medium transition-all border border-white/10 hover:border-white/20 hover:scale-105 active:scale-95 group overflow-hidden">
                <span class="relative z-10">Get Started</span>
                <div class="absolute inset-0 bg-gradient-to-r from-accent-500/0 via-accent-500/10 to-accent-500/0 translate-x-[-100%] group-hover:translate-x-[100%] transition-transform duration-1000"></div>
              </button>
            </div>
          </div>
        </div>
      </nav>

      <!-- Hero Section -->
      <section class="pt-32 pb-20 px-6 relative cinematic-section">
        <div class="max-w-7xl mx-auto">
          <div class="text-center max-w-4xl mx-auto space-y-8">
            <!-- Badge with stagger animation -->
            <div 
              class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-white/5 border border-white/10 text-sm text-slate-300 backdrop-blur-xl animate-fade-in hover:scale-105 transition-transform duration-300 cursor-pointer group"
              style="animation-delay: 100ms;"
            >
              <span class="relative flex h-2 w-2">
                <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-accent-400 opacity-75"></span>
                <span class="relative inline-flex rounded-full h-2 w-2 bg-accent-500"></span>
              </span>
              <span class="group-hover:text-white transition-colors">Design System v2.0</span>
            </div>
            
            <!-- Main title with gradient text and animation -->
            <h1 
              class="text-6xl lg:text-7xl font-bold tracking-tight animate-fade-in"
              style="animation-delay: 200ms;"
            >
              <span class="text-white block mb-2">Build faster with</span>
              <span 
                ref="scrambleTextRef"
                class="bg-gradient-to-r from-accent-400 via-cyan-400 to-violet-400 bg-clip-text text-transparent inline-block animate-gradient-shift bg-[length:200%_auto]"
              >
                {{ displayText }}
              </span>
            </h1>
            
            <!-- Description with stagger -->
            <p 
              class="text-xl text-slate-400 max-w-2xl mx-auto leading-relaxed animate-fade-in"
              style="animation-delay: 300ms;"
            >
              A collection of beautifully designed, production-ready components built with Vue 3, TypeScript, and Tailwind CSS.
            </p>
            
            <!-- CTA Buttons with hover effects -->
            <div 
              class="flex items-center justify-center gap-4 pt-4 animate-fade-in"
              style="animation-delay: 400ms;"
            >
              <div
                ref="magneticBtnRef"
                class="relative"
                @mousemove="onMagneticMove"
                @mouseleave="onMagneticLeave"
              >
                <button 
                  ref="primaryButtonRef"
                  class="group relative px-6 py-3 rounded-xl bg-gradient-to-r from-accent-500 to-cyan-500 text-white font-medium shadow-2xl shadow-accent-500/20 hover:shadow-accent-500/40 transition-all duration-300 overflow-hidden"
                  :style="magneticStyle"
                >
                  <span class="relative z-10 flex items-center">
                    <svg class="w-5 h-5 mr-2 group-hover:rotate-12 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                    </svg>
                    Explore Components
                  </span>
                  <!-- Ripple effect on click -->
                  <span 
                    v-for="ripple in buttonRipples" 
                    :key="ripple.id"
                    class="absolute rounded-full bg-white/30 pointer-events-none animate-ping"
                    :style="{
                      left: `${ripple.x}px`,
                      top: `${ripple.y}px`,
                      width: `${ripple.size}px`,
                      height: `${ripple.size}px`,
                      transform: 'translate(-50%, -50%)'
                    }"
                  ></span>
                  <!-- Shine effect -->
                  <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/20 to-transparent skew-x-12 translate-x-[-200%] group-hover:translate-x-[200%] transition-transform duration-1000"></div>
                </button>
              </div>
              
              <button 
                class="group relative px-6 py-3 rounded-xl text-slate-300 hover:text-white font-medium border border-white/10 hover:border-white/20 hover:bg-white/5 transition-all duration-300 hover:scale-105 active:scale-95 overflow-hidden"
              >
                <span class="relative z-10 flex items-center">
                  View on GitHub
                  <svg class="w-5 h-5 ml-2 group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                  </svg>
                </span>
              </button>
            </div>
            
            <!-- Feature checkmarks with stagger -->
            <div 
              class="flex items-center justify-center gap-12 pt-12 text-sm text-slate-500 animate-fade-in"
              style="animation-delay: 500ms;"
            >
              <div class="flex items-center gap-2 hover:text-slate-400 transition-colors cursor-pointer group">
                <svg class="w-4 h-4 text-accent-500 group-hover:scale-125 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                <span>30+ Animations</span>
              </div>
              <div class="flex items-center gap-2 hover:text-slate-400 transition-colors cursor-pointer group">
                <svg class="w-4 h-4 text-cyan-500 group-hover:scale-125 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                <span>TypeScript First</span>
              </div>
              <div class="flex items-center gap-2 hover:text-slate-400 transition-colors cursor-pointer group">
                <svg class="w-4 h-4 text-violet-500 group-hover:scale-125 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                <span>Dark Mode</span>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Features Showcase with Reveal Animations -->
      <section ref="featuresRef" class="py-20 px-6 relative cinematic-section">
        <div class="max-w-7xl mx-auto">
          <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <!-- Feature 1 -->
            <div 
              ref="feature1Ref"
              class="group relative backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 overflow-hidden transition-all duration-700"
              :class="{ 'opacity-0 translate-y-12': !feature1Visible, 'opacity-100 translate-y-0': feature1Visible }"
              @mouseenter="onFeatureHover($event, 0)"
              @mousemove="onFeatureMove($event, 0)"
              @mouseleave="onFeatureLeave(0)"
              :style="featureStyles[0]"
            >
              <!-- Animated gradient on hover -->
              <div class="absolute inset-0 bg-gradient-to-br from-accent-500/0 via-accent-500/5 to-cyan-500/0 opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
              
              <div class="relative z-10">
                <div class="w-16 h-16 rounded-2xl bg-gradient-to-br from-accent-500/20 to-cyan-500/20 border border-accent-500/30 flex items-center justify-center mb-6 group-hover:scale-110 group-hover:rotate-6 transition-all duration-500">
                  <svg class="w-8 h-8 text-accent-400 group-hover:text-accent-300 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                  </svg>
                </div>
                <h3 class="text-2xl font-bold text-white mb-3 group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-accent-400 group-hover:to-cyan-400 group-hover:bg-clip-text transition-all">Lightning Fast</h3>
                <p class="text-slate-400 group-hover:text-slate-300 transition-colors">Built with performance in mind. Every animation runs at 60fps for buttery smooth interactions.</p>
              </div>
              
              <!-- Shine effect -->
              <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/5 to-transparent translate-x-[-200%] group-hover:translate-x-[200%] transition-transform duration-1000"></div>
            </div>

            <!-- Feature 2 -->
            <div 
              ref="feature2Ref"
              class="group relative backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 overflow-hidden transition-all duration-700"
              :class="{ 'opacity-0 translate-y-12': !feature2Visible, 'opacity-100 translate-y-0': feature2Visible }"
              style="transition-delay: 100ms;"
              @mouseenter="onFeatureHover($event, 1)"
              @mousemove="onFeatureMove($event, 1)"
              @mouseleave="onFeatureLeave(1)"
              :style="featureStyles[1]"
            >
              <div class="absolute inset-0 bg-gradient-to-br from-violet-500/0 via-violet-500/5 to-purple-500/0 opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
              
              <div class="relative z-10">
                <div class="w-16 h-16 rounded-2xl bg-gradient-to-br from-violet-500/20 to-purple-500/20 border border-violet-500/30 flex items-center justify-center mb-6 group-hover:scale-110 group-hover:rotate-6 transition-all duration-500">
                  <svg class="w-8 h-8 text-violet-400 group-hover:text-violet-300 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01" />
                  </svg>
                </div>
                <h3 class="text-2xl font-bold text-white mb-3 group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-violet-400 group-hover:to-purple-400 group-hover:bg-clip-text transition-all">Fully Customizable</h3>
                <p class="text-slate-400 group-hover:text-slate-300 transition-colors">Every component is designed to be easily customizable with Tailwind CSS utilities.</p>
              </div>
              
              <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/5 to-transparent translate-x-[-200%] group-hover:translate-x-[200%] transition-transform duration-1000"></div>
            </div>

            <!-- Feature 3 -->
            <div 
              ref="feature3Ref"
              class="group relative backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 overflow-hidden transition-all duration-700"
              :class="{ 'opacity-0 translate-y-12': !feature3Visible, 'opacity-100 translate-y-0': feature3Visible }"
              style="transition-delay: 200ms;"
              @mouseenter="onFeatureHover($event, 2)"
              @mousemove="onFeatureMove($event, 2)"
              @mouseleave="onFeatureLeave(2)"
              :style="featureStyles[2]"
            >
              <div class="absolute inset-0 bg-gradient-to-br from-cyan-500/0 via-cyan-500/5 to-blue-500/0 opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
              
              <div class="relative z-10">
                <div class="w-16 h-16 rounded-2xl bg-gradient-to-br from-cyan-500/20 to-blue-500/20 border border-cyan-500/30 flex items-center justify-center mb-6 group-hover:scale-110 group-hover:rotate-6 transition-all duration-500">
                  <svg class="w-8 h-8 text-cyan-400 group-hover:text-cyan-300 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                  </svg>
                </div>
                <h3 class="text-2xl font-bold text-white mb-3 group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-cyan-400 group-hover:to-blue-400 group-hover:bg-clip-text transition-all">Enterprise Ready</h3>
                <p class="text-slate-400 group-hover:text-slate-300 transition-colors">Production-tested components with TypeScript support and comprehensive documentation.</p>
              </div>
              
              <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/5 to-transparent translate-x-[-200%] group-hover:translate-x-[200%] transition-transform duration-1000"></div>
            </div>
          </div>
        </div>
      </section>

      <!-- Stats Preview -->
      <section ref="statsRef" class="py-12 px-6 cinematic-section">
        <div class="max-w-7xl mx-auto">
          <div class="grid grid-cols-1 lg:grid-cols-4 gap-4">
            <div 
              v-for="(stat, index) in stats" 
              :key="index"
              class="group animate-fade-in"
              :style="{ animationDelay: `${index * 100}ms` }"
            >
              <div
                ref="statCardsRef"
                class="relative backdrop-blur-xl bg-white/[0.02] border rounded-2xl p-6 transition-all duration-500 cursor-pointer"
                :class="stat.borderColor"
                @mouseenter="onStatCardHover($event, index)"
                @mousemove="onStatCardMove($event, index)"
                @mouseleave="onStatCardLeave(index)"
                :style="statCardStyles[index]"
              >
                <!-- Glow effect on hover -->
                <div class="absolute inset-0 rounded-2xl opacity-0 group-hover:opacity-100 transition-opacity duration-500 pointer-events-none" :class="stat.glowClass"></div>
                
                <StatCard
                  :title="stat.title"
                  :value="stat.value"
                  :format="stat.format"
                  :change="stat.change"
                  :period="stat.period"
                  :color="stat.color"
                  class="relative z-10 bg-transparent border-0"
                >
                  <template #icon>
                    <svg class="w-5 h-5 text-white group-hover:scale-110 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" :d="stat.iconPath" />
                    </svg>
                  </template>
                </StatCard>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- 3D Flip Cards Section -->
      <section class="py-32 px-6 relative cinematic-section">
        <div class="max-w-7xl mx-auto">
          <div class="text-center mb-20">
            <h2 class="text-5xl lg:text-6xl font-bold text-white mb-6 tracking-tight">
              Experience the <span class="bg-gradient-to-r from-violet-400 via-purple-400 to-pink-400 bg-clip-text text-transparent">magic</span>
            </h2>
            <p class="text-xl text-slate-400 max-w-2xl mx-auto">
              Hover over the cards to reveal their secrets
            </p>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <!-- 3D Flip Card 1 -->
            <div 
              class="perspective-1000 h-80 cursor-pointer group"
              @click="flip3DCard(0)"
            >
              <div 
                class="relative w-full h-full transition-transform duration-700 preserve-3d"
                :class="{ 'rotate-y-180': flipped3DCards[0] }"
              >
                <!-- Front -->
                <div class="absolute inset-0 backface-hidden rounded-2xl backdrop-blur-xl bg-gradient-to-br from-accent-500/10 to-cyan-500/10 border border-accent-500/20 p-8 flex flex-col items-center justify-center group-hover:border-accent-500/40 transition-colors">
                  <div class="w-20 h-20 rounded-2xl bg-gradient-to-br from-accent-500 to-cyan-500 flex items-center justify-center mb-6 group-hover:scale-110 group-hover:rotate-12 transition-all shadow-2xl shadow-accent-500/50">
                    <svg class="w-10 h-10 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                    </svg>
                  </div>
                  <h3 class="text-2xl font-bold text-white mb-3">Performance</h3>
                  <p class="text-slate-400 text-center">Click to discover more</p>
                  <div class="mt-6 text-accent-400 animate-bounce">↻</div>
                </div>
                
                <!-- Back -->
                <div class="absolute inset-0 backface-hidden rotate-y-180 rounded-2xl backdrop-blur-xl bg-gradient-to-br from-accent-500/20 to-cyan-500/20 border border-accent-500/30 p-8 flex flex-col justify-center">
                  <h4 class="text-xl font-bold text-white mb-4">Blazing Fast</h4>
                  <ul class="space-y-3 text-slate-300">
                    <li class="flex items-start gap-2">
                      <svg class="w-5 h-5 text-accent-400 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                      </svg>
                      <span>60fps animations</span>
                    </li>
                    <li class="flex items-start gap-2">
                      <svg class="w-5 h-5 text-accent-400 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                      </svg>
                      <span>Optimized rendering</span>
                    </li>
                    <li class="flex items-start gap-2">
                      <svg class="w-5 h-5 text-accent-400 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                      </svg>
                      <span>Lazy loading</span>
                    </li>
                  </ul>
                </div>
              </div>
            </div>

            <!-- 3D Flip Card 2 -->
            <div 
              class="perspective-1000 h-80 cursor-pointer group"
              @click="flip3DCard(1)"
            >
              <div 
                class="relative w-full h-full transition-transform duration-700 preserve-3d"
                :class="{ 'rotate-y-180': flipped3DCards[1] }"
              >
                <!-- Front -->
                <div class="absolute inset-0 backface-hidden rounded-2xl backdrop-blur-xl bg-gradient-to-br from-violet-500/10 to-purple-500/10 border border-violet-500/20 p-8 flex flex-col items-center justify-center group-hover:border-violet-500/40 transition-colors">
                  <div class="w-20 h-20 rounded-2xl bg-gradient-to-br from-violet-500 to-purple-500 flex items-center justify-center mb-6 group-hover:scale-110 group-hover:rotate-12 transition-all shadow-2xl shadow-violet-500/50">
                    <svg class="w-10 h-10 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4" />
                    </svg>
                  </div>
                  <h3 class="text-2xl font-bold text-white mb-3">Customizable</h3>
                  <p class="text-slate-400 text-center">Click to discover more</p>
                  <div class="mt-6 text-violet-400 animate-bounce">↻</div>
                </div>
                
                <!-- Back -->
                <div class="absolute inset-0 backface-hidden rotate-y-180 rounded-2xl backdrop-blur-xl bg-gradient-to-br from-violet-500/20 to-purple-500/20 border border-violet-500/30 p-8 flex flex-col justify-center">
                  <h4 class="text-xl font-bold text-white mb-4">Built for You</h4>
                  <ul class="space-y-3 text-slate-300">
                    <li class="flex items-start gap-2">
                      <svg class="w-5 h-5 text-violet-400 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                      </svg>
                      <span>Tailwind utilities</span>
                    </li>
                    <li class="flex items-start gap-2">
                      <svg class="w-5 h-5 text-violet-400 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                      </svg>
                      <span>CSS variables</span>
                    </li>
                    <li class="flex items-start gap-2">
                      <svg class="w-5 h-5 text-violet-400 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                      </svg>
                      <span>Theme system</span>
                    </li>
                  </ul>
                </div>
              </div>
            </div>

            <!-- 3D Flip Card 3 -->
            <div 
              class="perspective-1000 h-80 cursor-pointer group"
              @click="flip3DCard(2)"
            >
              <div 
                class="relative w-full h-full transition-transform duration-700 preserve-3d"
                :class="{ 'rotate-y-180': flipped3DCards[2] }"
              >
                <!-- Front -->
                <div class="absolute inset-0 backface-hidden rounded-2xl backdrop-blur-xl bg-gradient-to-br from-cyan-500/10 to-blue-500/10 border border-cyan-500/20 p-8 flex flex-col items-center justify-center group-hover:border-cyan-500/40 transition-colors">
                  <div class="w-20 h-20 rounded-2xl bg-gradient-to-br from-cyan-500 to-blue-500 flex items-center justify-center mb-6 group-hover:scale-110 group-hover:rotate-12 transition-all shadow-2xl shadow-cyan-500/50">
                    <svg class="w-10 h-10 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                    </svg>
                  </div>
                  <h3 class="text-2xl font-bold text-white mb-3">Enterprise</h3>
                  <p class="text-slate-400 text-center">Click to discover more</p>
                  <div class="mt-6 text-cyan-400 animate-bounce">↻</div>
                </div>
                
                <!-- Back -->
                <div class="absolute inset-0 backface-hidden rotate-y-180 rounded-2xl backdrop-blur-xl bg-gradient-to-br from-cyan-500/20 to-blue-500/20 border border-cyan-500/30 p-8 flex flex-col justify-center">
                  <h4 class="text-xl font-bold text-white mb-4">Production Ready</h4>
                  <ul class="space-y-3 text-slate-300">
                    <li class="flex items-start gap-2">
                      <svg class="w-5 h-5 text-cyan-400 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                      </svg>
                      <span>TypeScript support</span>
                    </li>
                    <li class="flex items-start gap-2">
                      <svg class="w-5 h-5 text-cyan-400 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                      </svg>
                      <span>Accessibility</span>
                    </li>
                    <li class="flex items-start gap-2">
                      <svg class="w-5 h-5 text-cyan-400 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                      </svg>
                      <span>Documentation</span>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Impressive Metrics Section -->
      <section class="py-32 px-6 relative cinematic-section">
        <div class="max-w-7xl mx-auto">
          <!-- Section header -->
          <div class="text-center mb-20">
            <h2 class="text-5xl lg:text-6xl font-bold text-white mb-6 tracking-tight">
              Trusted by <span class="bg-gradient-to-r from-accent-400 via-cyan-400 to-violet-400 bg-clip-text text-transparent">thousands</span>
            </h2>
            <p class="text-xl text-slate-400 max-w-2xl mx-auto">
              Join the developers who are building the next generation of web applications
            </p>
          </div>

          <!-- Metrics Grid -->
          <div class="grid grid-cols-2 lg:grid-cols-4 gap-8 mb-20">
            <div 
              v-for="(metric, index) in impressiveMetrics" 
              :key="index"
              class="group text-center relative"
            >
              <div class="relative inline-block">
                <!-- Glow effect -->
                <div 
                  class="absolute inset-0 rounded-full blur-2xl transition-opacity duration-500"
                  :class="metric.glowColor"
                ></div>
                
                <!-- Number -->
                <div class="relative text-6xl lg:text-7xl font-bold mb-3 transition-all duration-500 group-hover:scale-110">
                  <span class="bg-gradient-to-br bg-clip-text text-transparent" :class="metric.gradient">
                    {{ metric.value }}
                  </span>
                  <span class="text-slate-400">{{ metric.suffix }}</span>
                </div>
              </div>
              
              <!-- Label -->
              <p class="text-sm font-medium text-slate-400 group-hover:text-slate-300 transition-colors uppercase tracking-wider">
                {{ metric.label }}
              </p>
            </div>
          </div>

          <!-- Testimonial Cards -->
          <div class="grid grid-cols-1 md:grid-cols-3 gap-7">
            <div 
              v-for="(testimonial, index) in testimonials" 
              :key="index"
              class="group backdrop-blur-xl bg-white/[0.02] border border-white/10 rounded-2xl p-8 hover:border-white/20 hover:bg-white/[0.04] transition-all duration-500 relative overflow-hidden"
            >
              <!-- Hover gradient -->
              <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-500" :class="testimonial.bgGradient"></div>
              
              <div class="relative z-10">
                <!-- Stars -->
                <div class="flex gap-1 mb-4">
                  <svg v-for="n in 5" :key="n" class="w-5 h-5 text-yellow-400 group-hover:scale-110 transition-transform" :style="{ transitionDelay: `${n * 50}ms` }" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                  </svg>
                </div>

                <!-- Quote -->
                <p class="text-slate-300 mb-6 leading-relaxed group-hover:text-white transition-colors">
                  "{{ testimonial.quote }}"
                </p>

                <!-- Author -->
                <div class="flex items-center gap-3">
                  <div class="w-10 h-10 rounded-full bg-gradient-to-br flex items-center justify-center text-white font-medium group-hover:scale-110 transition-transform" :class="testimonial.avatarGradient">
                    {{ testimonial.initials }}
                  </div>
                  <div>
                    <p class="text-sm font-medium text-white">{{ testimonial.author }}</p>
                    <p class="text-xs text-slate-500">{{ testimonial.role }}</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Components Grid -->
      <section class="py-20 px-6 cinematic-section" id="components">
        <div class="max-w-7xl mx-auto space-y-12">
          <!-- Section Header -->
          <div class="space-y-4">
            <h2 class="text-4xl font-bold text-white tracking-tight">Components</h2>
            <p class="text-lg text-slate-400 max-w-2xl">Production-ready components with delightful interactions and animations.</p>
          </div>

          <!-- Bento Grid Layout -->
          <div class="grid grid-cols-1 lg:grid-cols-12 gap-6">
            <!-- Buttons - Large Feature -->
            <div 
              ref="buttonsCardRef"
              class="lg:col-span-8 backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 transition-all duration-500 group hover:border-white/20"
              @mouseenter="onCardHover"
              @mousemove="onCardMouseMove"
              @mouseleave="onCardLeave"
              :style="cardStyle"
            >
              <div class="flex items-center justify-between mb-6">
                <div>
                  <h3 class="text-xl font-semibold text-white mb-2 group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-accent-400 group-hover:to-cyan-400 group-hover:bg-clip-text transition-all">Buttons</h3>
                  <p class="text-sm text-slate-400">Multiple variants with ripple effects</p>
                </div>
                <span class="px-3 py-1 rounded-full bg-accent-500/10 text-accent-400 text-xs font-medium border border-accent-500/20 animate-pulse-subtle">Interactive</span>
              </div>
              
              <div class="space-y-6">
                <div class="flex flex-wrap gap-3">
                  <BaseButton variant="primary" size="sm" @click="showSuccessToast" class="hover:scale-110 transition-transform">Primary</BaseButton>
                  <BaseButton variant="secondary" size="sm" class="hover:scale-110 transition-transform">Secondary</BaseButton>
                  <BaseButton variant="outline" size="sm" class="hover:scale-110 transition-transform">Outline</BaseButton>
                  <BaseButton variant="ghost" size="sm" class="hover:scale-110 transition-transform">Ghost</BaseButton>
                  <BaseButton variant="danger" size="sm" @click="showErrorToast" class="hover:scale-110 transition-transform">Danger</BaseButton>
                  <BaseButton variant="success" size="sm" class="hover:scale-110 transition-transform">Success</BaseButton>
                </div>
                
                <div class="flex items-center gap-3 pt-4 border-t border-white/5">
                  <BaseButton variant="primary" :loading="true" size="sm">Loading</BaseButton>
                  <BaseButton variant="primary" :disabled="true" size="sm">Disabled</BaseButton>
                </div>
              </div>
            </div>

            <!-- Inputs - Medium Feature -->
            <div class="lg:col-span-4 backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 hover:border-white/20 transition-all duration-500 group">
              <h3 class="text-xl font-semibold text-white mb-2 group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-cyan-400 group-hover:to-blue-400 group-hover:bg-clip-text transition-all">Form Inputs</h3>
              <p class="text-sm text-slate-400 mb-6">With validation states</p>
              
              <div class="space-y-4">
                <BaseInput
                  v-model="email"
                  label="Email"
                  placeholder="you@example.com"
                  class="text-sm transform hover:scale-[1.02] transition-transform"
                />
                <BaseInput
                  v-model="successInput"
                  label="Success state"
                  :success="true"
                  class="text-sm transform hover:scale-[1.02] transition-transform"
                />
              </div>
            </div>

            <!-- Cards - Medium Feature -->
            <div class="lg:col-span-6 backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 hover:border-white/20 transition-all duration-500 group">
              <h3 class="text-xl font-semibold text-white mb-2 group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-violet-400 group-hover:to-purple-400 group-hover:bg-clip-text transition-all">Card Variants</h3>
              <p class="text-sm text-slate-400 mb-6">Different styles for different needs</p>
              
              <div class="grid grid-cols-2 gap-4">
                <div class="relative p-4 rounded-xl bg-white/[0.03] border border-white/10 hover:border-accent-500/30 transition-all group/card cursor-pointer overflow-hidden">
                  <div class="absolute inset-0 bg-gradient-to-br from-accent-500/0 to-accent-500/10 opacity-0 group-hover/card:opacity-100 transition-opacity"></div>
                  <div class="relative z-10">
                    <div class="w-10 h-10 rounded-lg bg-gradient-to-br from-accent-500 to-cyan-500 mb-3 group-hover/card:scale-110 group-hover/card:rotate-3 transition-transform shadow-lg"></div>
                    <p class="text-sm font-medium text-white">Elevated</p>
                    <p class="text-xs text-slate-500 mt-1">With lift effect</p>
                  </div>
                </div>
                
                <div class="relative p-4 rounded-xl backdrop-blur-xl bg-white/5 border border-white/20 hover:border-cyan-500/50 transition-all group/card cursor-pointer overflow-hidden">
                  <div class="absolute inset-0 bg-gradient-to-br from-cyan-500/0 to-cyan-500/10 opacity-0 group-hover/card:opacity-100 transition-opacity"></div>
                  <div class="relative z-10">
                    <div class="w-10 h-10 rounded-lg bg-gradient-to-br from-cyan-500 to-blue-500 mb-3 group-hover/card:scale-110 group-hover/card:rotate-3 transition-transform shadow-lg"></div>
                    <p class="text-sm font-medium text-white">Glass</p>
                    <p class="text-xs text-slate-500 mt-1">Glassmorphism</p>
                  </div>
                </div>
              </div>
            </div>

            <!-- Empty State - Medium Feature -->
            <div class="lg:col-span-6 backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 hover:border-white/20 transition-all duration-500 group">
              <h3 class="text-xl font-semibold text-white mb-6 group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-blue-400 group-hover:to-cyan-400 group-hover:bg-clip-text transition-all">Empty States</h3>
              
              <div class="text-center py-6">
                <div class="w-12 h-12 rounded-xl bg-blue-500/10 border border-blue-500/20 flex items-center justify-center mx-auto mb-4 group-hover:scale-110 group-hover:rotate-3 transition-transform">
                  <svg class="w-6 h-6 text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4" />
                  </svg>
                </div>
                <h4 class="text-sm font-medium text-white mb-2">No products yet</h4>
                <p class="text-xs text-slate-400 mb-4">Get started by creating your first product</p>
                <BaseButton variant="outline" size="xs" class="hover:scale-110 transition-transform">Create Product</BaseButton>
              </div>
            </div>

            <!-- Loading States - Small Feature -->
            <div class="lg:col-span-4 backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 hover:border-white/20 transition-all duration-500 group">
              <h3 class="text-xl font-semibold text-white mb-2 group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-slate-400 group-hover:to-slate-200 group-hover:bg-clip-text transition-all">Loading</h3>
              <p class="text-sm text-slate-400 mb-6">Skeleton screens</p>
              
              <LoadingSkeleton type="card" />
            </div>

            <!-- Toast System - Large Feature -->
            <div class="lg:col-span-8 backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 hover:border-white/20 transition-all duration-500 group">
              <div class="flex items-center justify-between mb-8">
                <div>
                  <h3 class="text-xl font-semibold text-white mb-2 group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-success-400 group-hover:to-emerald-400 group-hover:bg-clip-text transition-all">Toast Notifications</h3>
                  <p class="text-sm text-slate-400">Beautiful feedback messages</p>
                </div>
                <span class="px-3 py-1 rounded-full bg-success-500/10 text-success-400 text-xs font-medium border border-success-500/20 animate-pulse-subtle">Try it</span>
              </div>
              
              <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                <button
                  @click="showSuccessToast"
                  class="relative p-4 rounded-xl bg-success-500/5 border border-success-500/20 hover:bg-success-500/10 hover:border-success-500/30 transition-all group/toast text-left overflow-hidden hover:scale-105 active:scale-95"
                >
                  <div class="absolute inset-0 bg-gradient-to-br from-success-500/10 to-transparent opacity-0 group-hover/toast:opacity-100 transition-opacity"></div>
                  <div class="relative z-10">
                    <div class="w-8 h-8 rounded-lg bg-success-500/20 flex items-center justify-center mb-3 group-hover/toast:scale-110 group-hover/toast:rotate-12 transition-transform">
                      <svg class="w-4 h-4 text-success-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                      </svg>
                    </div>
                    <p class="text-sm font-medium text-white">Success</p>
                  </div>
                  <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent translate-x-[-200%] group-hover/toast:translate-x-[200%] transition-transform duration-1000"></div>
                </button>

                <button
                  @click="showErrorToast"
                  class="relative p-4 rounded-xl bg-danger-500/5 border border-danger-500/20 hover:bg-danger-500/10 hover:border-danger-500/30 transition-all group/toast text-left overflow-hidden hover:scale-105 active:scale-95"
                >
                  <div class="absolute inset-0 bg-gradient-to-br from-danger-500/10 to-transparent opacity-0 group-hover/toast:opacity-100 transition-opacity"></div>
                  <div class="relative z-10">
                    <div class="w-8 h-8 rounded-lg bg-danger-500/20 flex items-center justify-center mb-3 group-hover/toast:scale-110 group-hover/toast:rotate-12 transition-transform">
                      <svg class="w-4 h-4 text-danger-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                      </svg>
                    </div>
                    <p class="text-sm font-medium text-white">Error</p>
                  </div>
                  <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent translate-x-[-200%] group-hover/toast:translate-x-[200%] transition-transform duration-1000"></div>
                </button>

                <button
                  @click="showWarningToast"
                  class="relative p-4 rounded-xl bg-warning-500/5 border border-warning-500/20 hover:bg-warning-500/10 hover:border-warning-500/30 transition-all group/toast text-left overflow-hidden hover:scale-105 active:scale-95"
                >
                  <div class="absolute inset-0 bg-gradient-to-br from-warning-500/10 to-transparent opacity-0 group-hover/toast:opacity-100 transition-opacity"></div>
                  <div class="relative z-10">
                    <div class="w-8 h-8 rounded-lg bg-warning-500/20 flex items-center justify-center mb-3 group-hover/toast:scale-110 group-hover/toast:rotate-12 transition-transform">
                      <svg class="w-4 h-4 text-warning-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                      </svg>
                    </div>
                    <p class="text-sm font-medium text-white">Warning</p>
                  </div>
                  <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent translate-x-[-200%] group-hover/toast:translate-x-[200%] transition-transform duration-1000"></div>
                </button>

                <button
                  @click="showInfoToast"
                  class="relative p-4 rounded-xl bg-blue-500/5 border border-blue-500/20 hover:bg-blue-500/10 hover:border-blue-500/30 transition-all group/toast text-left overflow-hidden hover:scale-105 active:scale-95"
                >
                  <div class="absolute inset-0 bg-gradient-to-br from-blue-500/10 to-transparent opacity-0 group-hover/toast:opacity-100 transition-opacity"></div>
                  <div class="relative z-10">
                    <div class="w-8 h-8 rounded-lg bg-blue-500/20 flex items-center justify-center mb-3 group-hover/toast:scale-110 group-hover/toast:rotate-12 transition-transform">
                      <svg class="w-4 h-4 text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                      </svg>
                    </div>
                    <p class="text-sm font-medium text-white">Info</p>
                  </div>
                  <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent translate-x-[-200%] group-hover/toast:translate-x-[200%] transition-transform duration-1000"></div>
                </button>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Footer -->
      <footer class="py-20 px-6 border-t border-white/5 relative overflow-hidden cinematic-section">
        <!-- Animated background -->
        <div class="absolute inset-0 bg-gradient-to-t from-accent-500/5 via-transparent to-transparent pointer-events-none"></div>
        
        <div class="max-w-7xl mx-auto relative z-10">
          <div class="grid grid-cols-1 md:grid-cols-4 gap-12 mb-12">
            <!-- Brand -->
            <div class="space-y-4">
              <div class="flex items-center gap-3 group cursor-pointer">
                <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-accent-400 to-cyan-500 flex items-center justify-center group-hover:scale-110 group-hover:rotate-6 transition-all duration-300 shadow-lg shadow-accent-500/20">
                  <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                  </svg>
                </div>
                <span class="text-lg font-semibold text-white">FerreCloud</span>
              </div>
              <p class="text-sm text-slate-400 leading-relaxed">Building the future of web interfaces, one component at a time.</p>
            </div>

            <!-- Product -->
            <div class="space-y-4">
              <h4 class="text-sm font-semibold text-white uppercase tracking-wider">Product</h4>
              <ul class="space-y-3">
                <li><a href="#" class="text-sm text-slate-400 hover:text-white hover:translate-x-1 inline-block transition-all">Components</a></li>
                <li><a href="#" class="text-sm text-slate-400 hover:text-white hover:translate-x-1 inline-block transition-all">Templates</a></li>
                <li><a href="#" class="text-sm text-slate-400 hover:text-white hover:translate-x-1 inline-block transition-all">Pricing</a></li>
                <li><a href="#" class="text-sm text-slate-400 hover:text-white hover:translate-x-1 inline-block transition-all">Changelog</a></li>
              </ul>
            </div>

            <!-- Resources -->
            <div class="space-y-4">
              <h4 class="text-sm font-semibold text-white uppercase tracking-wider">Resources</h4>
              <ul class="space-y-3">
                <li><a href="#" class="text-sm text-slate-400 hover:text-white hover:translate-x-1 inline-block transition-all">Documentation</a></li>
                <li><a href="#" class="text-sm text-slate-400 hover:text-white hover:translate-x-1 inline-block transition-all">Guides</a></li>
                <li><a href="#" class="text-sm text-slate-400 hover:text-white hover:translate-x-1 inline-block transition-all">Examples</a></li>
                <li><a href="#" class="text-sm text-slate-400 hover:text-white hover:translate-x-1 inline-block transition-all">Support</a></li>
              </ul>
            </div>

            <!-- Social -->
            <div class="space-y-4">
              <h4 class="text-sm font-semibold text-white uppercase tracking-wider">Connect</h4>
              <div class="flex items-center gap-3">
                <a href="#" class="w-10 h-10 rounded-lg bg-white/5 border border-white/10 flex items-center justify-center text-slate-400 hover:text-white hover:bg-white/10 hover:scale-110 hover:border-accent-500/30 transition-all group">
                  <svg class="w-5 h-5 group-hover:rotate-12 transition-transform" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
                  </svg>
                </a>
                <a href="#" class="w-10 h-10 rounded-lg bg-white/5 border border-white/10 flex items-center justify-center text-slate-400 hover:text-white hover:bg-white/10 hover:scale-110 hover:border-cyan-500/30 transition-all group">
                  <svg class="w-5 h-5 group-hover:rotate-12 transition-transform" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z"/>
                  </svg>
                </a>
                <a href="#" class="w-10 h-10 rounded-lg bg-white/5 border border-white/10 flex items-center justify-center text-slate-400 hover:text-white hover:bg-white/10 hover:scale-110 hover:border-violet-500/30 transition-all group">
                  <svg class="w-5 h-5 group-hover:rotate-12 transition-transform" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
                  </svg>
                </a>
              </div>
            </div>
          </div>

          <!-- Bottom bar -->
          <div class="pt-8 border-t border-white/5 flex flex-col md:flex-row items-center justify-between gap-4">
            <div class="flex items-center gap-6 text-sm text-slate-500">
              <span>© 2026 FerreCloud</span>
              <span>Built with Vue 3</span>
              <span>•</span>
              <span>TypeScript</span>
              <span>•</span>
              <span>Tailwind CSS</span>
            </div>
            
            <div class="flex items-center gap-6 text-sm text-slate-500">
              <a href="#" class="hover:text-white transition-colors">Privacy</a>
              <a href="#" class="hover:text-white transition-colors">Terms</a>
              <a href="#" class="hover:text-white transition-colors">Cookies</a>
            </div>
          </div>
        </div>
      </footer>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, computed, onMounted, onUnmounted, watch } from 'vue'
import { useMouse, useWindowScroll, useElementHover, useRafFn, useIntersectionObserver } from '@vueuse/core'
import BaseButton from '@/components/BaseButton.vue'
import BaseInput from '@/components/BaseInput.vue'
import StatCard from '@/components/StatCard.vue'
import LoadingSkeleton from '@/components/LoadingSkeleton.vue'
import { useToast } from '@/composables/useToast'

const toast = useToast()

// Mouse tracking for spotlight effect
const containerRef = ref<HTMLElement>()
const spotlightRef = ref<HTMLElement>()
const { x: mouseX, y: mouseY } = useMouse({ type: 'client' })
const isHovering = useElementHover(containerRef)

// Scroll tracking for navbar and parallax
const { y: scrollY } = useWindowScroll()

// Calculate scroll progress percentage
const scrollProgress = computed(() => {
  if (typeof window === 'undefined') return 0
  const windowHeight = window.innerHeight
  const documentHeight = document.documentElement.scrollHeight
  const scrolled = scrollY.value
  const maxScroll = documentHeight - windowHeight
  return maxScroll > 0 ? Math.min((scrolled / maxScroll) * 100, 100) : 0
})

// Custom cursor effects
const cursorScale = ref(1)
const trailIntervalMs = 24
let lastTrailTime = 0
const customCursorEnabled = ref(false)
const cursorVisible = ref(false)
const reducedMotion = ref(false)
const lowPerfMode = ref(false)
let cursorMediaQuery: MediaQueryList | null = null
let reducedMotionQuery: MediaQueryList | null = null
let cursorListenersAttached = false

const handlePointerMove = () => {
  cursorVisible.value = true
}

const handlePointerLeave = () => {
  cursorVisible.value = false
}

const handleWindowBlur = () => {
  cursorVisible.value = false
}

const isInteractiveElement = (el: Element | null) => !!el?.closest('button, a, input, [role="button"]')

const handlePointerOver = (event: MouseEvent) => {
  if (isInteractiveElement(event.target as Element)) {
    updateCursorScale(true)
  }
}

const handlePointerOut = (event: MouseEvent) => {
  const target = event.target as Element
  const related = event.relatedTarget as Element | null
  if (isInteractiveElement(target) && !isInteractiveElement(related)) {
    updateCursorScale(false)
  }
}

const attachCursorListeners = () => {
  if (cursorListenersAttached || typeof window === 'undefined') return
  window.addEventListener('mousemove', handlePointerMove)
  window.addEventListener('mouseleave', handlePointerLeave)
  window.addEventListener('blur', handleWindowBlur)
  document.addEventListener('mouseover', handlePointerOver)
  document.addEventListener('mouseout', handlePointerOut)
  cursorListenersAttached = true
}

const detachCursorListeners = () => {
  if (!cursorListenersAttached || typeof window === 'undefined') return
  window.removeEventListener('mousemove', handlePointerMove)
  window.removeEventListener('mouseleave', handlePointerLeave)
  window.removeEventListener('blur', handleWindowBlur)
  document.removeEventListener('mouseover', handlePointerOver)
  document.removeEventListener('mouseout', handlePointerOut)
  cursorListenersAttached = false
}

const updateCursorCapability = () => {
  if (typeof window === 'undefined' || !cursorMediaQuery) return
  const enabled = cursorMediaQuery.matches
  if (enabled !== customCursorEnabled.value) {
    customCursorEnabled.value = enabled
    if (enabled) {
      attachCursorListeners()
    } else {
      detachCursorListeners()
      cursorVisible.value = false
    }
  }
}

// Ambient cinematic sound
const audioEnabled = ref(false)
let audioContext: AudioContext | null = null
let audioNodes: {
  osc1: OscillatorNode
  osc2: OscillatorNode
  gain: GainNode
  filter: BiquadFilterNode
} | null = null

const startAmbientSound = async () => {
  if (audioContext || typeof window === 'undefined') return
  const AudioContextClass = window.AudioContext || (window as any).webkitAudioContext
  if (!AudioContextClass) return

  audioContext = new AudioContextClass()
  await audioContext.resume()

  const gain = audioContext.createGain()
  gain.gain.value = 0.015

  const filter = audioContext.createBiquadFilter()
  filter.type = 'lowpass'
  filter.frequency.value = 380

  const osc1 = audioContext.createOscillator()
  osc1.type = 'sine'
  osc1.frequency.value = 110

  const osc2 = audioContext.createOscillator()
  osc2.type = 'triangle'
  osc2.frequency.value = 220

  osc1.connect(filter)
  osc2.connect(filter)
  filter.connect(gain)
  gain.connect(audioContext.destination)

  osc1.start()
  osc2.start()

  audioNodes = { osc1, osc2, gain, filter }
  audioEnabled.value = true
}

const stopAmbientSound = async () => {
  if (audioNodes) {
    audioNodes.osc1.stop()
    audioNodes.osc2.stop()
    audioNodes = null
  }
  if (audioContext) {
    await audioContext.close()
    audioContext = null
  }
  audioEnabled.value = false
}

const toggleAmbientSound = () => {
  if (audioEnabled.value) {
    stopAmbientSound()
  } else {
    startAmbientSound()
  }
}

// Cursor trail effect
interface CursorParticle {
  x: number
  y: number
  opacity: number
}
const cursorTrail = ref<CursorParticle[]>([])
const maxTrailLength = 15

// Click particle explosion
interface ClickParticle {
  id: number
  x: number
  y: number
  color: string
  opacity: number
  scale: number
  vx: number
  vy: number
}
const clickParticles = ref<ClickParticle[]>([])
let particleId = 0
let lastClickTime = 0
const clickCooldownMs = 300
const maxClickParticles = 60
let burstCount = 0
let burstWindowStart = 0
const burstLimit = 4
const burstWindowMs = 1000
const burstCooldownMs = 2000

// Create particle explosion on click
const createParticleExplosion = (x: number, y: number) => {
  const now = typeof performance !== 'undefined' ? performance.now() : Date.now()
  if (burstWindowStart === 0 || now - burstWindowStart > burstWindowMs) {
    burstWindowStart = now
    burstCount = 0
  }
  if (burstCount >= burstLimit) {
    if (now - burstWindowStart < burstCooldownMs) return
    burstWindowStart = now
    burstCount = 0
  }
  if (now - lastClickTime < clickCooldownMs) return
  lastClickTime = now
  if (clickParticles.value.length > maxClickParticles) {
    clickParticles.value = clickParticles.value.slice(-maxClickParticles)
  }
  const colors = ['#14b8a6', '#22d3ee', '#8b5cf6', '#a855f7', '#ec4899']
  const particleCount = 6
  
  burstCount += 1
  for (let i = 0; i < particleCount; i++) {
    const angle = (Math.PI * 2 * i) / particleCount
    const velocity = 2 + Math.random() * 3
    const color = colors[Math.floor(Math.random() * colors.length)] ?? '#14b8a6'
    
    clickParticles.value.push({
      id: particleId++,
      x,
      y,
      color,
      opacity: 1,
      scale: 1,
      vx: Math.cos(angle) * velocity,
      vy: Math.sin(angle) * velocity
    })
  }
}

// Animate click particles
useRafFn(() => {
  if (lowPerfMode.value) return
  clickParticles.value = clickParticles.value.map(p => ({
    ...p,
    x: p.x + p.vx,
    y: p.y + p.vy,
    vx: p.vx * 0.98,
    vy: p.vy * 0.98 + 0.1, // gravity
    opacity: p.opacity * 0.95,
    scale: p.scale * 0.97
  })).filter(p => p.opacity > 0.01)
})

// Add global click listener
const handleClickExplosion = (e: MouseEvent) => {
  if (!customCursorEnabled.value || lowPerfMode.value) return
  createParticleExplosion(e.clientX, e.clientY)
}

onMounted(() => {
  document.addEventListener('click', handleClickExplosion)
})

onUnmounted(() => {
  document.removeEventListener('click', handleClickExplosion)
  stopAmbientSound()
  if (cursorMediaQuery) {
    cursorMediaQuery.removeEventListener('change', updateCursorCapability)
  }
  if (reducedMotionQuery) {
    reducedMotionQuery.removeEventListener('change', updatePerfMode)
  }
  detachCursorListeners()
})

// Add particle to trail
watch([mouseX, mouseY], () => {
  if (!customCursorEnabled.value || !cursorVisible.value) return
  const now = typeof performance !== 'undefined' ? performance.now() : Date.now()
  if (now - lastTrailTime < trailIntervalMs) return
  lastTrailTime = now
  cursorTrail.value.push({
    x: mouseX.value,
    y: mouseY.value,
    opacity: 0.8
  })
  
  if (cursorTrail.value.length > maxTrailLength) {
    cursorTrail.value.shift()
  }
})

// Fade out trail particles
useRafFn(() => {
  if (!customCursorEnabled.value || lowPerfMode.value) return
  cursorTrail.value = cursorTrail.value.map(particle => ({
    ...particle,
    opacity: particle.opacity * 0.92
  })).filter(particle => particle.opacity > 0.05)
})

// Cursor scale on interactive elements
const updateCursorScale = (isHovering: boolean) => {
  cursorScale.value = isHovering ? 1.5 : 1
}

onMounted(() => {
  if (typeof window !== 'undefined') {
    reducedMotionQuery = window.matchMedia('(prefers-reduced-motion: reduce)')
    reducedMotion.value = reducedMotionQuery.matches
    reducedMotionQuery.addEventListener('change', (event) => {
      reducedMotion.value = event.matches
      updatePerfMode()
    })

    const memory = (navigator as any).deviceMemory || 0
    const cores = navigator.hardwareConcurrency || 0
    lowPerfMode.value = memory > 0 ? memory <= 4 : cores > 0 ? cores <= 4 : false

    cursorMediaQuery = window.matchMedia('(hover: hover) and (pointer: fine)')
    updateCursorCapability()
    cursorMediaQuery.addEventListener('change', updateCursorCapability)
  }
})

const updatePerfMode = () => {
  if (typeof window === 'undefined') return
  const memory = (navigator as any).deviceMemory || 0
  const cores = navigator.hardwareConcurrency || 0
  const lowPerf = memory > 0 ? memory <= 4 : cores > 0 ? cores <= 4 : false
  lowPerfMode.value = lowPerf || reducedMotion.value
  updateCursorCapability()
}

// Form values
const email = ref('')
const successInput = ref('valid@email.com')

// Text scramble effect
const scrambleTextRef = ref<HTMLElement>()
const targetText = 'enterprise components'
const displayText = ref('')
const scrambleChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*'

const scrambleText = () => {
  let iteration = 0
  const maxIterations = targetText.length
  
  const interval = setInterval(() => {
    displayText.value = targetText
      .split('')
      .map((char, index) => {
        if (index < iteration) {
          return targetText[index]
        }
        return scrambleChars[Math.floor(Math.random() * scrambleChars.length)]
      })
      .join('')
    
    iteration += 1 / 3
    
    if (iteration >= maxIterations) {
      clearInterval(interval)
      displayText.value = targetText
    }
  }, 50)
}

onMounted(() => {
  setTimeout(() => scrambleText(), 500)
})

// Cinematic section reveal
let cinematicObserver: IntersectionObserver | null = null

const setupCinematicSections = () => {
  if (typeof window === 'undefined') return
  const sections = Array.from(document.querySelectorAll('.cinematic-section'))
  cinematicObserver = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('is-visible')
        }
      })
    },
    { threshold: 0.15, rootMargin: '0px 0px -10% 0px' }
  )
  sections.forEach((section) => cinematicObserver?.observe(section))
}

onMounted(() => {
  setupCinematicSections()
})

onUnmounted(() => {
  cinematicObserver?.disconnect()
})

// Magnetic button effect
const magneticBtnRef = ref<HTMLElement>()
const primaryButtonRef = ref<HTMLElement>()
const magneticStyle = ref({})

const onMagneticMove = (event: MouseEvent) => {
  const btn = magneticBtnRef.value
  if (!btn) return
  
  const rect = btn.getBoundingClientRect()
  const x = event.clientX - rect.left - rect.width / 2
  const y = event.clientY - rect.top - rect.height / 2
  
  const distance = Math.sqrt(x * x + y * y)
  const maxDistance = 100
  
  if (distance < maxDistance) {
    const strength = Math.max(0, 1 - distance / maxDistance)
    const translateX = x * strength * 0.3
    const translateY = y * strength * 0.3
    
    magneticStyle.value = {
      transform: `translate(${translateX}px, ${translateY}px) scale(${1 + strength * 0.05})`,
      transition: 'transform 0.2s cubic-bezier(0.16, 1, 0.3, 1)'
    }
  }
}

const onMagneticLeave = () => {
  magneticStyle.value = {
    transform: 'translate(0, 0) scale(1)',
    transition: 'transform 0.5s cubic-bezier(0.16, 1, 0.3, 1)'
  }
}

// Button ripple effect
interface ButtonRipple {
  id: number
  x: number
  y: number
  size: number
}
const buttonRipples = ref<ButtonRipple[]>([])
let rippleId = 0

onMounted(() => {
  const btn = primaryButtonRef.value
  if (btn) {
    btn.addEventListener('click', (e) => {
      const rect = btn.getBoundingClientRect()
      const x = e.clientX - rect.left
      const y = e.clientY - rect.top
      
      const ripple = {
        id: rippleId++,
        x,
        y,
        size: 0
      }
      
      buttonRipples.value.push(ripple)
      
      setTimeout(() => {
        buttonRipples.value = buttonRipples.value.filter(r => r.id !== ripple.id)
      }, 600)
    })
  }
})

// 3D Flip Cards
const flipped3DCards = reactive<Record<number, boolean>>({
  0: false,
  1: false,
  2: false
})

const flip3DCard = (index: number) => {
  flipped3DCards[index] = !flipped3DCards[index]
}

// Features reveal on scroll
const featuresRef = ref<HTMLElement>()
const feature1Ref = ref<HTMLElement>()
const feature2Ref = ref<HTMLElement>()
const feature3Ref = ref<HTMLElement>()
const feature1Visible = ref(false)
const feature2Visible = ref(false)
const feature3Visible = ref(false)

useIntersectionObserver(
  feature1Ref,
  ([entry]) => {
    if (entry && entry.isIntersecting) feature1Visible.value = true
  },
  { threshold: 0.2 }
)

useIntersectionObserver(
  feature2Ref,
  ([entry]) => {
    if (entry && entry.isIntersecting) feature2Visible.value = true
  },
  { threshold: 0.2 }
)

useIntersectionObserver(
  feature3Ref,
  ([entry]) => {
    if (entry && entry.isIntersecting) feature3Visible.value = true
  },
  { threshold: 0.2 }
)

// Feature cards 3D tilt effect
const featureStyles = reactive<Record<number, any>>({
  0: {},
  1: {},
  2: {}
})

const onFeatureHover = (event: MouseEvent, index: number) => {
  const card = event.currentTarget as HTMLElement
  const rect = card.getBoundingClientRect()
  const x = event.clientX - rect.left
  const y = event.clientY - rect.top
  
  const centerX = rect.width / 2
  const centerY = rect.height / 2
  
  const rotateX = (y - centerY) / 15
  const rotateY = (centerX - x) / 15
  
  featureStyles[index] = {
    transform: `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) scale3d(1.03, 1.03, 1.03)`,
    transition: 'transform 0.1s ease'
  }
}

const onFeatureMove = (event: MouseEvent, index: number) => {
  const card = event.currentTarget as HTMLElement
  const rect = card.getBoundingClientRect()
  const x = event.clientX - rect.left
  const y = event.clientY - rect.top
  
  const centerX = rect.width / 2
  const centerY = rect.height / 2
  
  const rotateX = (y - centerY) / 15
  const rotateY = (centerX - x) / 15
  
  featureStyles[index] = {
    transform: `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) scale3d(1.03, 1.03, 1.03)`,
    transition: 'none'
  }
}

const onFeatureLeave = (index: number) => {
  featureStyles[index] = {
    transform: 'perspective(1000px) rotateX(0deg) rotateY(0deg) scale3d(1, 1, 1)',
    transition: 'transform 0.6s cubic-bezier(0.16, 1, 0.3, 1)'
  }
}

// Stats data with animations
const statsRef = ref<HTMLElement>()
const statCardsRef = ref<HTMLElement[]>([])
const stats = [
  {
    title: 'Total Revenue',
    value: 284503,
    format: 'currency' as const,
    change: 18.2,
    period: 'from last month',
    color: 'accent' as const,
    borderColor: 'border-white/10 hover:border-accent-500/30',
    glowClass: 'bg-accent-500/10',
    iconPath: 'M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z'
  },
  {
    title: 'Active Users',
    value: 8234,
    format: 'compact' as const,
    change: 12.5,
    period: 'from last week',
    color: 'blue' as const,
    borderColor: 'border-white/10 hover:border-blue-500/30',
    glowClass: 'bg-blue-500/10',
    iconPath: 'M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z'
  },
  {
    title: 'Conversion',
    value: 12.8,
    format: 'percentage' as const,
    change: 8.1,
    period: 'from yesterday',
    color: 'success' as const,
    borderColor: 'border-white/10 hover:border-success-500/30',
    glowClass: 'bg-success-500/10',
    iconPath: 'M13 7h8m0 0v8m0-8l-8 8-4-4-6 6'
  },
  {
    title: 'New Orders',
    value: 1542,
    format: 'number' as const,
    change: -3.2,
    period: 'from last month',
    color: 'purple' as const,
    borderColor: 'border-white/10 hover:border-purple-500/30',
    glowClass: 'bg-purple-500/10',
    iconPath: 'M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z'
  }
]

// 3D Card tilt effect
const statCardStyles = reactive<Record<number, any>>({})

const onStatCardHover = (event: MouseEvent, index: number) => {
  const card = (event.currentTarget as HTMLElement)
  const rect = card.getBoundingClientRect()
  const x = event.clientX - rect.left
  const y = event.clientY - rect.top
  
  const centerX = rect.width / 2
  const centerY = rect.height / 2
  
  const rotateX = (y - centerY) / 10
  const rotateY = (centerX - x) / 10
  
  statCardStyles[index] = {
    transform: `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) scale3d(1.02, 1.02, 1.02)`,
    transition: 'transform 0.1s ease'
  }
}

const onStatCardMove = (event: MouseEvent, index: number) => {
  const card = (event.currentTarget as HTMLElement)
  const rect = card.getBoundingClientRect()
  const x = event.clientX - rect.left
  const y = event.clientY - rect.top
  
  const centerX = rect.width / 2
  const centerY = rect.height / 2
  
  const rotateX = (y - centerY) / 10
  const rotateY = (centerX - x) / 10
  
  statCardStyles[index] = {
    transform: `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) scale3d(1.02, 1.02, 1.02)`,
    transition: 'none'
  }
}

const onStatCardLeave = (index: number) => {
  statCardStyles[index] = {
    transform: 'perspective(1000px) rotateX(0deg) rotateY(0deg) scale3d(1, 1, 1)',
    transition: 'transform 0.5s ease'
  }
}

// Card hover effects for buttons card
const buttonsCardRef = ref<HTMLElement>()
const cardStyle = ref({})

const onCardHover = () => {
  // Optional: Add any initialization on hover
}

const onCardMouseMove = (event: MouseEvent) => {
  const card = buttonsCardRef.value
  if (!card) return
  
  const rect = card.getBoundingClientRect()
  const x = event.clientX - rect.left
  const y = event.clientY - rect.top
  
  const centerX = rect.width / 2
  const centerY = rect.height / 2
  
  const rotateX = (y - centerY) / 30
  const rotateY = (centerX - x) / 30
  
  cardStyle.value = {
    transform: `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg)`,
    transition: 'none'
  }
}

const onCardLeave = () => {
  cardStyle.value = {
    transform: 'perspective(1000px) rotateX(0deg) rotateY(0deg)',
    transition: 'transform 0.5s ease'
  }
}

// Impressive Metrics Data
const impressiveMetrics = [
  {
    value: '50',
    suffix: '+',
    label: 'Components',
    gradient: 'from-accent-400 to-cyan-500',
    glowColor: 'bg-accent-500/20 opacity-0 group-hover:opacity-100'
  },
  {
    value: '10',
    suffix: 'K+',
    label: 'Downloads',
    gradient: 'from-cyan-400 to-blue-500',
    glowColor: 'bg-cyan-500/20 opacity-0 group-hover:opacity-100'
  },
  {
    value: '98',
    suffix: '%',
    label: 'Satisfaction',
    gradient: 'from-violet-400 to-purple-500',
    glowColor: 'bg-violet-500/20 opacity-0 group-hover:opacity-100'
  },
  {
    value: '24',
    suffix: '/7',
    label: 'Support',
    gradient: 'from-emerald-400 to-green-500',
    glowColor: 'bg-emerald-500/20 opacity-0 group-hover:opacity-100'
  }
]

// Testimonials Data
const testimonials = [
  {
    quote: 'The best component library I\'ve ever used. The animations are smooth and the code is clean.',
    author: 'Sarah Chen',
    role: 'Lead Developer at TechCorp',
    initials: 'SC',
    avatarGradient: 'from-accent-500 to-cyan-500',
    bgGradient: 'bg-gradient-to-br from-accent-500/5 to-transparent'
  },
  {
    quote: 'Incredible attention to detail. These components saved us months of development time.',
    author: 'Michael Torres',
    role: 'CTO at StartupXYZ',
    initials: 'MT',
    avatarGradient: 'from-violet-500 to-purple-500',
    bgGradient: 'bg-gradient-to-br from-violet-500/5 to-transparent'
  },
  {
    quote: 'The design system documentation is comprehensive. Our whole team loves working with it.',
    author: 'Emma Wilson',
    role: 'Product Designer',
    initials: 'EW',
    avatarGradient: 'from-cyan-500 to-blue-500',
    bgGradient: 'bg-gradient-to-br from-cyan-500/5 to-transparent'
  }
]

// Toast examples with enhanced messages
const showSuccessToast = () => {
  toast.success('🎉 Amazing! Changes saved', {
    description: 'Your product has been updated successfully.',
  })
}

const showErrorToast = () => {
  toast.error('❌ Oops! Something went wrong', {
    description: 'Please check your internet connection and try again.',
  })
}

const showWarningToast = () => {
  toast.warning('⚠️ Session expiring soon', {
    description: 'Please save your work to avoid losing changes.',
  })
}

const showInfoToast = () => {
  toast.info('💡 New update available', {
    description: 'Update now to get the latest features and improvements.',
  })
}
</script>
