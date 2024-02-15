<script setup lang="ts">
import { ref, computed, watch, onBeforeMount } from 'vue';

interface Data {
  [cityKey: string]: {
    [departmentKey: string]: {
      staff: string[];
      brigades: string[];
    };
  };
}

const data: Data = {
  'Москва': {
    'MSK-1': {
      staff: ['Маккартни П.', 'Леннон Д.'],
      brigades: {
        'A': ['День', 'Ночь'],
        'B': ['День', 'Ночи']
      }
    },
    'MSK-2': {
      staff: ['Харрисон Д.', 'Старр Р.'],
      brigades: {
        'A': ['День', 'Ночь'],
        'B': ['День', 'Ночи']
      }
    },
  },
  'Санкт': {
    'SPB-1': {
      staff: ['Сатклифф С.', 'Бест П.'],
      brigades: {
        'A': ['День', 'Ночь'],
        'B': ['День', 'Ночи']
      }
    },
    'SPB-2': {
      staff: ['Чепмен Н.', 'Мур Т.'],
      brigades: {
        'A': ['День', 'Ночь'],
        'B': ['День', 'Ночи']
      }
    },
  },
  'NSK': {
    'NSK-1': {
      staff: ['Ньюби Д.', 'Никол Д.'],
      brigades: {
        'A': ['День', 'Ночь'],
        'B': ['День', 'Ночи']
      }
    },
  }
};

const selectedCity = ref('Москва');
const selectedDepartment = ref('');
const selectedStaffer = ref('');
const selectedBrigade = ref('');
const selectedChange = ref('');

const departments = computed(() => data[selectedCity.value] || {});
const staffers = computed(() => departments.value[selectedDepartment.value]?.staff || []);
const brigades = computed(() => departments.value[selectedDepartment.value]?.brigades || {});
const changes = computed(() => brigades.value[selectedBrigade.value] || []);

const updateDepartment = () => {
  selectedDepartment.value = Object.keys(departments.value)[0] || '';
  updateStafferAndBrigade();
};

const updateStafferAndBrigade = () => {
  selectedStaffer.value = staffers.value[0] || '';
  selectedBrigade.value = Object.keys(brigades.value)[0] || '';
  updateChange();
};

const updateChange = () => {
  selectedChange.value = changes.value[0] || '';
};

watch(selectedCity, updateDepartment);

onBeforeMount(updateDepartment);
</script>

<template>
  <div class="container mt-3">
    <form>
      <div class="form-group">
        <label for="city">Город:</label>
        <select id="city" class="form-control" v-model="selectedCity" @change="updateDepartment">
          <option v-for="(city, cityKey) in data" :key="cityKey" :value="cityKey">{{ cityKey }}</option>
        </select>
      </div>

      <div class="form-group">
        <label for="department">Цех:</label>
        <select id="department" class="form-control" v-model="selectedDepartment" @change="updateStafferAndBrigade">
          <option v-for="(department, departmentKey) in departments" :key="departmentKey" :value="departmentKey">{{
            departmentKey }}</option>
        </select>
      </div>

      <div class="form-group">
        <label for="staffer">Сотрудник:</label>
        <select id="staffer" class="form-control" v-model="selectedStaffer">
          <option v-for="staff in staffers" :key="staff" :value="staff">{{ staff }}</option>
        </select>
      </div>

      <div class="form-group">
        <label for="brigade">Бригада:</label>
        <select id="brigade" class="form-control" v-model="selectedBrigade" @change="updateChange">
          <option v-for="(brigade, brigadeKey) in brigades" :key="brigadeKey" :value="brigadeKey">{{ brigadeKey }}
          </option>
        </select>
      </div>

      <div class="form-group">
        <label for="change">Смена:</label>
        <select id="change" class="form-control" v-model="selectedChange">
          <option v-for="change in changes" :key="change" :value="change">{{ change }}</option>
        </select>
      </div>
    </form>
  </div>
</template>