import 'vue';

declare module '@vue/runtime-core' {
  export interface ComponentCustomProperties {
    $formatDate: (dateString: string) => string;
  }
}