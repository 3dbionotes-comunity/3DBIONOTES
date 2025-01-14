import React from "react";
import { getCompositionRoot } from "../../../compositionRoot";
import { Covid19Info } from "../../../domain/entities/Covid19Info";
import { AppContext } from "../../contexts/app-context";
import { Root } from "./Root";
import "./App.css";

declare global {
    interface Window {
        app: { data: Covid19Info };
    }
}

interface AppProps {}

export const App: React.FC<AppProps> = React.memo(() => {
    const compositionRoot = getCompositionRoot();
    const appContext = { compositionRoot, config: {} };

    return (
        <AppContext.Provider value={appContext}>
            <Root />
        </AppContext.Provider>
    );
});
