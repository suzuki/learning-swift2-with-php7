<?php

class View
{
    private $formTemplate     = __DIR__ . '/index.html.tmpl';
    private $confirmTemplate  = __DIR__ . '/confirm.html.tmpl';
    private $completeTemplate = __DIR__ . '/complete.html.tmpl';

    public function getFormHtml(array $params): string
    {
        $html = file_get_contents($this->formTemplate);
        $html = $this->renderTemplate($html, $params);

        return $html;
    }

    public function getConfirmHtml(array $params): string
    {
        $html = file_get_contents($this->confirmTemplate);
        $html = $this->renderTemplate($html, $params);

        return $html;
    }

    public function getCompleteHtml(array $params): string
    {
        $html = file_get_contents($this->completeTemplate);
        $html = $this->renderTemplate($html, $params);

        return $html;
    }

    private function renderTemplate(string $html, array $params): string
    {
        $replaceKey = [];
        $replaceValue = [];

        foreach ($params as $key => $value) {
            $replaceKey[] = '/{{ ' . $key . ' }}/';
            $replaceValue[] = htmlspecialchars($value, ENT_QUOTES , 'UTF-8');
        }

        $replaceKey[] = '/{{ action }}/';
        $replaceValue[] = 'index.php';

        return preg_replace($replaceKey, $replaceValue, $html);
    }
}

class App
{
    private $view;
    private $keys = ['email', 'title', 'message', 'next'];

    public function __construct(View $view)
    {
        $this->view = $view;
    }

    public function run() {
        $params = $this->parseGetVars();
        $html = '';

        $next = $params['next'] ?? '';

        switch ($next) {
            case 'confirm':
                $html = $this->view->getConfirmHtml($params);
                break;
            case 'complete':
                $html = $this->view->getCompleteHtml($params);
                break;
            default:
                $html = $this->view->getFormHtml($params);
        }

        $this->response($html);
    }

    private function parseGetVars(): array
    {
        $vars = ['email' => '', 'title' => '', 'message' => '', 'next' => ''];

        foreach ($this->keys as $key) {
            $vars[$key] = $_GET[$key] ?? '';
        }

        return $vars;
    }

    private function response(string $html)
    {
        echo $html;
    }
}

$view = new View();
$app = new App($view);
$app->run();
