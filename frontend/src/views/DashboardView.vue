<template>
  <div class="dashboard-page">
    <TopNavbar @toggleSidebar="sidebarOpen = !sidebarOpen" />
    <div class="dashboard-layout">
      <Sidebar :isOpen="sidebarOpen" @closeSidebar="sidebarOpen = false" />
      
      <main class="dashboard-main">
        <!-- Welcome -->
        <div class="dashboard-welcome">
          <h1>Buenos días, <span class="highlight">{{ userName }}</span> 👋</h1>
          <p>Aquí tienes un resumen de tu negocio hoy.</p>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid">
          <StatCard title="Ventas del Día" value="$2,847,350" color="teal" :change="12.5" period="vs ayer">
            <template #icon>
              <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
            </template>
          </StatCard>
          <StatCard title="Pedidos Hoy" value="48" color="blue" :change="8.2" period="vs ayer">
            <template #icon>
              <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" /></svg>
            </template>
          </StatCard>
          <StatCard title="Productos Activos" value="1,248" color="purple" :change="3.1" period="este mes">
            <template #icon>
              <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" /></svg>
            </template>
          </StatCard>
          <StatCard title="Clientes Nuevos" value="23" color="orange" :change="-2.4" period="vs ayer">
            <template #icon>
              <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" /></svg>
            </template>
          </StatCard>
        </div>

        <!-- Content Grid -->
        <div class="content-grid">
          <!-- Sales Chart -->
          <div class="chart-section">
            <BaseCard>
              <template #header>
                <div class="card-header-flex">
                  <div>
                    <h3>Resumen de Ventas</h3>
                    <p>Últimos 7 días</p>
                  </div>
                  <div class="chart-actions">
                    <button class="action-btn active">Semanal</button>
                    <button class="action-btn">Mensual</button>
                  </div>
                </div>
              </template>
              
              <div class="chart-placeholder">
                <div class="chart-container">
                  <svg class="chart-svg" preserveAspectRatio="none" viewBox="0 0 400 200">
                    <defs>
                      <linearGradient id="chartGrad" x1="0" y1="0" x2="0" y2="1">
                        <stop offset="0%" stop-color="rgba(20,184,166,0.3)" />
                        <stop offset="100%" stop-color="rgba(20,184,166,0)" />
                      </linearGradient>
                    </defs>
                    <path d="M0 180 Q50 160, 80 140 T160 100 T240 120 T320 60 T400 80 V200 H0 Z" fill="url(#chartGrad)" />
                    <path d="M0 180 Q50 160, 80 140 T160 100 T240 120 T320 60 T400 80" fill="none" stroke="#14b8a6" stroke-width="2.5" stroke-linecap="round" />
                    <!-- Dots -->
                    <circle cx="80" cy="140" r="4" fill="#14b8a6" />
                    <circle cx="160" cy="100" r="4" fill="#14b8a6" />
                    <circle cx="240" cy="120" r="4" fill="#14b8a6" />
                    <circle cx="320" cy="60" r="4" fill="#14b8a6" />
                    <circle cx="400" cy="80" r="4" fill="#14b8a6" />
                  </svg>
                  <div class="chart-grid-lines">
                    <div class="grid-line"></div>
                    <div class="grid-line"></div>
                    <div class="grid-line"></div>
                    <div class="grid-line"></div>
                  </div>
                </div>
              </div>
            </BaseCard>
          </div>

          <!-- Top Products -->
          <div class="products-section">
            <BaseCard :noPadding="true">
              <template #header>
                <div class="card-header-flex">
                  <h3>Top Productos</h3>
                  <a href="#" class="view-all-link">Ver todos →</a>
                </div>
              </template>
              <div class="products-list">
                <div v-for="(product, i) in topProducts" :key="i" class="product-item">
                  <div class="product-icon" :class="product.colorClass">{{ product.emoji }}</div>
                  <div class="product-info">
                    <p class="product-name">{{ product.name }}</p>
                    <p class="product-sold">{{ product.sold }} vendidos</p>
                  </div>
                  <p class="product-revenue">${{ product.revenue }}</p>
                </div>
              </div>
            </BaseCard>
          </div>
        </div>

        <!-- Recent Orders -->
        <div class="orders-section">
          <BaseCard :noPadding="true">
            <template #header>
              <div class="card-header-flex">
                 <div>
                    <h3>Pedidos Recientes</h3>
                    <p>Últimas transacciones del día</p>
                 </div>
                 <button class="action-btn-outline">Ver todos</button>
              </div>
            </template>
            <div class="table-container">
              <table>
                <thead>
                  <tr>
                    <th>Pedido</th>
                    <th>Cliente</th>
                    <th>Productos</th>
                    <th>Total</th>
                    <th>Estado</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="order in recentOrders" :key="order.id">
                    <td><span class="order-id">#{{ order.id }}</span></td>
                    <td>
                      <div class="customer-cell">
                        <div class="customer-avatar">{{ order.customer.charAt(0) }}</div>
                        <span>{{ order.customer }}</span>
                      </div>
                    </td>
                    <td class="items-cell">{{ order.items }} item{{ order.items > 1 ? 's' : '' }}</td>
                    <td class="total-cell">${{ order.total }}</td>
                    <td>
                      <span :class="['status-badge', statusClasses[order.status]]">
                        {{ order.status }}
                      </span>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </BaseCard>
        </div>
      </main>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useAuthStore } from '@/stores/auth'
import TopNavbar from '@/components/TopNavbar.vue'
import Sidebar from '@/components/Sidebar.vue'
import StatCard from '@/components/StatCard.vue'
import BaseCard from '@/components/BaseCard.vue'

const authStore = useAuthStore()
const sidebarOpen = ref(false)

const userName = computed(() => {
  const email = authStore.user?.email || ''
  return email.split('@')[0] || 'Usuario'
})

const topProducts = [
  { name: 'Cemento Gris 50kg', sold: 342, revenue: '1,710,000', colorClass: 'sky', emoji: '🏗️' },
  { name: 'Pintura Blanca 1gal', sold: 256, revenue: '768,000', colorClass: 'amber', emoji: '🎨' },
  { name: 'Tubería PVC 1/2"', sold: 198, revenue: '594,000', colorClass: 'emerald', emoji: '🔧' },
  { name: 'Cable Eléctrico #12', sold: 167, revenue: '501,000', colorClass: 'violet', emoji: '⚡' },
  { name: 'Tornillos 1" x100', sold: 145, revenue: '290,000', colorClass: 'rose', emoji: '🔩' },
]

const recentOrders = [
  { id: '001247', customer: 'María García', items: 5, total: '187,500', status: 'Completado' },
  { id: '001246', customer: 'Carlos López', items: 3, total: '92,300', status: 'En proceso' },
  { id: '001245', customer: 'Ana Rodríguez', items: 8, total: '456,200', status: 'Completado' },
  { id: '001244', customer: 'Pedro Sánchez', items: 2, total: '34,800', status: 'Pendiente' },
  { id: '001243', customer: 'Laura Martínez', items: 6, total: '278,900', status: 'Completado' },
]

const statusClasses: Record<string, string> = {
  'Completado': 'status-emerald',
  'En proceso': 'status-sky',
  'Pendiente': 'status-amber',
  'Cancelado': 'status-rose',
}
</script>

<style scoped>
.dashboard-page {
  min-height: 100vh;
  background: #080e1e; /* surface-base */
  display: flex; flex-direction: column;
}

.dashboard-layout {
  display: flex; flex: 1; overflow: hidden;
}

.dashboard-main {
  flex: 1; overflow-y: auto;
  padding: 1.5rem;
}

@media (min-width: 1024px) { .dashboard-main { padding: 2rem; } }

/* Welcome */
.dashboard-welcome { margin-bottom: 2rem; }
.dashboard-welcome h1 { font-family: 'Plus Jakarta Sans', sans-serif; font-size: 1.5rem; font-weight: 700; color: white; margin-bottom: 0.5rem; }
.dashboard-welcome p { font-size: 0.95rem; color: #94a3b8; }
.highlight { background: linear-gradient(to right, #2dd4bf, #22d3ee); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }

@media (min-width: 640px) { .dashboard-welcome h1 { font-size: 2rem; } }

/* Stats Grid */
.stats-grid {
  display: grid; grid-template-columns: 1fr; gap: 1rem; margin-bottom: 2rem;
}
@media (min-width: 640px) { .stats-grid { grid-template-columns: 1fr 1fr; } }
@media (min-width: 1280px) { .stats-grid { grid-template-columns: repeat(4, 1fr); } }

/* Content Grid */
.content-grid {
  display: grid; grid-template-columns: 1fr; gap: 1.5rem; margin-bottom: 2rem;
}
@media (min-width: 1280px) { .content-grid { grid-template-columns: 2fr 1fr; } }

/* Headers */
.card-header-flex {
  display: flex; align-items: center; justify-content: space-between;
}
.card-header-flex h3 { font-size: 1.1rem; font-weight: 700; color: white; margin-bottom: 0.2rem; }
.card-header-flex p { font-size: 0.85rem; color: #94a3b8; }

/* Actions */
.chart-actions { display: flex; gap: 0.5rem; }
.action-btn {
  padding: 0.4rem 0.8rem; border-radius: 8px; font-size: 0.75rem; font-weight: 600; cursor: pointer; border: none; transition: all 0.2s;
}
.action-btn.active { background: rgba(20, 184, 166, 0.15); color: #2dd4bf; border: 1px solid rgba(20, 184, 166, 0.2); }
.action-btn:not(.active) { background: transparent; color: #94a3b8; }
.action-btn:not(.active):hover { background: rgba(255,255,255,0.05); color: white; }

.view-all-link { color: #2dd4bf; font-size: 0.8rem; font-weight: 600; text-decoration: none; }
.action-btn-outline {
  background: rgba(20, 184, 166, 0.1); border: 1px solid rgba(20, 184, 166, 0.2);
  color: #2dd4bf; font-size: 0.85rem; font-weight: 600; padding: 0.5rem 1rem;
  border-radius: 10px; cursor: pointer; transition: all 0.2s;
}
.action-btn-outline:hover { background: rgba(20, 184, 166, 0.15); }

/* Chart */
.chart-placeholder { height: 260px; display: flex; align-items: center; justify-content: center; }
.chart-container { position: relative; width: 100%; height: 100%; }
.chart-svg { width: 100%; height: 100%; }

.chart-grid-lines {
  position: absolute; inset: 0; display: flex; flex-direction: column; justify-content: space-between; padding: 1rem 0; pointer-events: none;
}
.grid-line { border-top: 1px dashed rgba(255,255,255,0.06); }

/* Products List */
.product-item {
  display: flex; align-items: center; gap: 0.75rem; padding: 0.85rem 1.5rem;
  border-bottom: 1px solid rgba(255,255,255,0.04); transition: background 0.2s;
}
.product-item:hover { background: rgba(255,255,255,0.02); }
.product-item:last-child { border-bottom: none; }

.product-icon {
  width: 40px; height: 40px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 1.2rem;
}
.product-icon.sky { background: rgba(14, 165, 233, 0.1); }
.product-icon.amber { background: rgba(245, 158, 11, 0.1); }
.product-icon.emerald { background: rgba(16, 185, 129, 0.1); }
.product-icon.violet { background: rgba(139, 92, 246, 0.1); }
.product-icon.rose { background: rgba(244, 63, 94, 0.1); }

.product-info { flex: 1; min-width: 0; }
.product-name { font-size: 0.9rem; font-weight: 500; color: #e2e8f0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.product-sold { font-size: 0.75rem; color: #94a3b8; }
.product-revenue { font-size: 0.9rem; font-weight: 600; color: #e2e8f0; }

/* Table */
.table-container { overflow-x: auto; }
table { width: 100%; border-collapse: collapse; }
th {
  text-align: left; padding: 0.75rem 1.5rem; font-size: 0.75rem; font-weight: 600; color: #94a3b8; text-transform: uppercase; letter-spacing: 0.05em; border-bottom: 1px solid rgba(255,255,255,0.06);
}
td { padding: 1rem 1.5rem; border-bottom: 1px solid rgba(255,255,255,0.04); vertical-align: middle; font-size: 0.9rem; color: #cbd5e1; }
tr:hover td { background: rgba(255,255,255,0.02); }

.order-id { font-family: monospace; color: #2dd4bf; }
.customer-cell { display: flex; align-items: center; gap: 0.75rem; }
.customer-avatar {
  width: 32px; height: 32px; border-radius: 8px; background: rgba(255,255,255,0.08); display: flex; align-items: center; justify-content: center; font-size: 0.8rem; font-weight: 600; color: #e2e8f0;
}
.items-cell { color: #94a3b8; }
.total-cell { font-weight: 600; color: #f1f5f9; }

.status-badge {
  padding: 0.25rem 0.75rem; border-radius: 999px; font-size: 0.75rem; font-weight: 600;
}
.status-emerald { background: rgba(16, 185, 129, 0.1); color: #34d399; }
.status-sky { background: rgba(14, 165, 233, 0.1); color: #38bdf8; }
.status-amber { background: rgba(245, 158, 11, 0.1); color: #fbbf24; }
.status-rose { background: rgba(244, 63, 94, 0.1); color: #fb7185; }

</style>
