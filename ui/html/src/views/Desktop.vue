<template>
    <div class="desktop flex flex-col w-full h-full overflow-hidden">
        <Workspace/>
        <TaskBar/>
        <StartMenu/>
        <Calendar/>
        <NotificationCenter/>
    </div>
</template>

<script>
import Workspace from '../components/Workspace'
import TaskBar from '../components/TaskBar'
import StartMenu from '../components/StartMenu'
import NotificationCenter from '../components/NotificationCenter'
import Calendar from '../components/Calendar'
import { mapGetters } from "vuex";
import api from "../api/axios";

export default {
    name: 'Desktop',
    components: {
        Workspace,
        TaskBar,
        StartMenu,
        Calendar,
        NotificationCenter
    },
    created(){
        window.addEventListener('keydown', (e) => {
            if (e.key == 'Escape') { async () => {
                try {
                    await api.post("exitMenu");
                } catch (error) {
                    await api.post("error", error.message);
                }
            }}   
        });
	},
	computed: {
		...mapGetters(["playerID"]),
	},
	methods: {
		sendError(text) {
			this.error = text;
			setTimeout(() => {
				this.error = "";
			}, 3000);
		},
		async sendData() {
			if (this.userName.length < 3) {
				return this.sendError("Your name should be longer than 2 characters.");
			}
			if (this.message.length < 4) {
				return this.sendError(
					"Your message should be longer than 3 characters."
				);
			}
			if (!this.typeOfMessage) {
				return this.sendError("You must specify the type of message.");
			}

			try {
				await api.post("receiveData", {
					userName: this.userName,
					message: this.message,
					typeOfMessage: this.typeOfMessage,
				});
			} catch (error) {
				await api.post("error", error);
			}
		},
		async exitMenu() {
			try {
				await api.post("exitMenu");
			} catch (error) {
				await api.post("error", error.message);
			}
		},
	},
}
</script>

<style lang="scss" scoped>

.desktop {
    background-image: url('../assets/wallpapers/light.jpg');
    background-position: center;
    background-size: cover;
}

.dark {
    .desktop {
        background-image: url('../assets/wallpapers/dark.jpg');
    }
}

</style>