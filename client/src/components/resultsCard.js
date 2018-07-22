import React, {Component} from 'react';
import {Container, Segment, Divider, Image, Item} from 'semantic-ui-react'
import ReactTable from "react-table";
import _ from 'lodash'
import {style} from 'react-table/react-table.css'

class ResultsCard extends Component {
    buildInventoryTable () {
        let product = this.props.product;
        let inventories = this.props.inventories;
        const columns = [
            {
                Header: "Inventory",
                columns: [
                    {
                        Header: "Count",
                        accessor: "count",
                        aggregate: vals => {
                            return _.sum(vals);
                        },
                        filterable: false,
                        Aggregated: row =>
                            <span>
                                {row.value}
                            </span>,
                        Footer: 'Total:  ' + product.total_inventory
                    }
                ]
            },
            {
                Header: "Pivoted Info",
                columns: [
                    {
                        Header: "Style",
                        id: 'style',
                        accessor: 'style',
                        PivotValue: ({value}) =>
                            <span style={{color: "darkgreen"}}>
                                                  {value}
                                                </span>
                    }, {
                        Header: "Waist",
                        id: 'waist',
                        accessor: "waist"
                    },
                    {
                        Header: "Length",
                        id: 'length',
                        accessor: 'length'
                    }
                ]
            }
        ]

        return (
            <ReactTable
                data={inventories}
                columns={columns}
                defaultPageSize={5}
                className="-striped -highlight"
                pivotBy={["style", "waist", "length"]}
                defaultSorted={[
                    {id: "waist", aesc: true},
                    {id: "style", aesc: true},
                    {id: "length", aesc: true}
                ]}
                collapseOnSortingChange={false}
                filterable={true}
            />
        )
    }

    render() {
        return (
            <Container text>
                <br/>
                <Segment>
                    <Divider horizontal>
                        <h1>{_.toUpper(this.props.product.name)}</h1>
                    </Divider>
                    <Item.Group>
                        <Item>
                            <Item.Content>
                                <Image src={this.props.product.image} fluid/>
                                <Item.Meta>Description:</Item.Meta>
                                <Item.Description>
                                    {this.props.product.description}
                                </Item.Description>
                            </Item.Content>
                        </Item>
                    </Item.Group>
                    <Divider horizontal>
                        <h3>Inventory Table</h3>
                    </Divider>
                    {this.buildInventoryTable()}
                </Segment>
            </Container>
        )
    }
}

export default ResultsCard;