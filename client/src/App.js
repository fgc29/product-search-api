import React, {Component} from 'react';
import {Input, Container} from 'semantic-ui-react'
import ResultsCard from './components/resultsCard'
import _ from 'lodash'


class App extends Component {
    constructor () {
        super();
        this.state = {};
        this.getProduct = this.getProduct.bind(this);
        this.search = this.search.bind(this);
        this._handleKeyPress = this._handleKeyPress.bind(this);
    }

    search (endpoint) {
        return window.fetch(endpoint)
            .then(response => response.json())
            .catch(error => console.log(error))

    }

    getProduct(product, event) {
        this.search('/api/products/search?product=' + product)
            .then(product => {
                if (product !== {}) {
                    this.setState({product: product, inventories: product.inventories})
                } else {
                    this.setState({product: {}})
                }
            })
            .then(()=> {
                event.target.parentElement.classList.remove('loading');
             })


    }

    _handleKeyPress (e) {
        if (e.key === 'Enter') {
            e.target.parentElement.classList.add('loading');
            e.persist();
            this.getProduct(e.target.value,e)
        }
    }

    displayResults () {
        if (!_.isEmpty(this.state.product)) {
            return <ResultsCard product={this.state.product} inventories={this.state.inventories}></ResultsCard>
        }
    }

    render() {
        return (
            <Container text>
                <br/>
                <Input icon='search' placeholder='Search Api for Product...' onKeyPress={this._handleKeyPress} fluid/>
                {this.displayResults()}
            </Container>
        )
    }
}

export default App;